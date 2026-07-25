program MHLMcpServer;

{$APPTYPE CONSOLE}

uses
  Vcl.Forms,
  System.Classes,
  System.SysUtils,
  System.JSON,
  dm_user in '..\..\Program\DataModules\dm_user.pas' {DMUser: TDataModule},
  unit_MCP_Transport in 'unit_MCP_Transport.pas',
  unit_MCP_Protocol in 'unit_MCP_Protocol.pas',
  unit_MCP_Json in 'unit_MCP_Json.pas',
  unit_MCP_Tools_Library in 'unit_MCP_Tools_Library.pas',
  unit_MCP_Fb2Extract in 'unit_MCP_Fb2Extract.pas';

// Extracts one FB2 file's text and section structure and prints it as a
// single JSON line, exactly like a tool result would look, but with no MCP
// envelope. Runs before the server/DMUser bootstrap (see the dispatch below)
// -- ExtractFb2 touches no database, so this needs neither DMUser nor a
// system database to exist. Still goes through TMcpTransport, not Writeln,
// so the same "only the transport writes to stdout" discipline holds here
// too.
procedure RunExtractMode(const FileName: string);
var
  Stream: TFileStream;
  Extraction: TFb2Extraction;
  Root: TJSONObject;
  Arr: TJSONArray;
  Entry: TJSONObject;
  Transport: TMcpTransport;
  I: Integer;
begin
  Transport := TMcpTransport.Create;
  try
    Stream := TFileStream.Create(FileName, fmOpenRead or fmShareDenyNone);
    try
      Extraction := ExtractFb2(Stream);
    finally
      Stream.Free;
    end;

    Arr := TJSONArray.Create;
    try
      for I := 0 to High(Extraction.Sections) do
      begin
        Entry := TJSONObject.Create;
        try
          Entry.AddPair('title', Extraction.Sections[I].Title);
          Entry.AddPair('level', TJSONNumber.Create(Extraction.Sections[I].Level));
          Entry.AddPair('offset', TJSONNumber.Create(Extraction.Sections[I].Offset));
          Entry.AddPair('length', TJSONNumber.Create(Extraction.Sections[I].Length));
        except
          Entry.Free;
          raise;
        end;
        Arr.AddElement(Entry);
      end;
    except
      Arr.Free;
      raise;
    end;

    Root := TJSONObject.Create;
    try
      Root.AddPair('text', Extraction.Text);
      Root.AddPair('sections', Arr);
      Root.AddPair('structured', TJSONBool.Create(Extraction.Structured));
      Root.AddPair('total_length', TJSONNumber.Create(Length(Extraction.Text)));
      Transport.WriteMessage(Root.ToJSON);
    finally
      Root.Free;
    end;
  finally
    Transport.Free;
  end;
end;

// IMPORTANT: nothing in this project may write to stdout except TMcpTransport.
// A single stray WriteLn corrupts every JSON-RPC response.
//
// This process links the VCL because the DAO layer does, but it creates no
// forms and runs no message loop.
//
// Note: unlike MyHomeLib.dpr, this does NOT call FirstHinstanceRunning —
// several server instances may run alongside the running app.
//
// DMUser is deliberately NOT created here. unit_MCP_Tools_Library boots it
// lazily, on the first tool call, via EnsureLibraryInitialized -- so a
// missing system database surfaces as a normal tool error (system_db_missing)
// instead of TDMUser.Init silently creating a brand-new one. That is also why
// every tool registration below is wrapped in Guarded(...): it is the one
// path by which DMUser gets initialized.

var
  Server: TMcpServer;

begin
  // --extract is a pure, database-free CLI mode (see RunExtractMode above),
  // so it is handled before Application.Initialize / DMUser ever come into
  // play. Any failure here is reported to stderr, never stdout -- the
  // transport already owns stdout for the (unused, in this mode) JSON line.
  //
  // Checked on ParamStr(1) alone, not on ParamCount = 2: an unquoted path
  // containing spaces is split by the OS into several ParamStr entries, and
  // falling through to server mode in that case would silently start a
  // JSON-RPC server that blocks forever reading stdin, with no indication
  // that --extract was even recognised. There is no reliable way to
  // reconstruct one path from several already-split arguments, so this
  // fails fast with a clear message instead of guessing.
  if (ParamCount >= 1) and (ParamStr(1) = '--extract') then
  begin
    if ParamCount <> 2 then
    begin
      Writeln(ErrOutput,
        Format('--extract requires exactly one file path argument (got %d). ' +
          'If the path contains spaces, quote it.', [ParamCount - 1]));
      Halt(1);
    end;

    try
      RunExtractMode(ParamStr(2));
    except
      on E: Exception do
      begin
        Writeln(ErrOutput, 'FB2 extraction failed: ' + E.Message);
        Halt(1);
      end;
    end;
    Exit;
  end;

  Application.Initialize;

  Server := TMcpServer.Create;
  try
    // echo_args is a temporary diagnostic tool from Task 3, removed in
    // Task 10. It never touches DMUser itself, but it is still wrapped in
    // Guarded(...) so "every registration is wrapped" stays mechanically
    // true rather than merely true by convention.
    Server.RegisterTool('echo_args', 'Test helper', TJSONObject.Create,
      Guarded(
        function(const Args: TJSONObject): TJSONObject
        var
          Limit: Integer;
          Clamped: Boolean;
        begin
          Limit := ArgIntClamped(Args, 'limit', 25, 1, 200, Clamped);
          Result := TJSONObject.Create;
          Result.AddPair('limit', TJSONNumber.Create(Limit));
          Result.AddPair('clamped', TJSONBool.Create(Clamped));
        end));

    RegisterLibraryTools(Server);
    Server.Run;
  finally
    Server.Free;
    if Assigned(DMUser) then
      FreeAndNil(DMUser);
  end;
end.
