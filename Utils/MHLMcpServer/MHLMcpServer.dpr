program MHLMcpServer;

{$APPTYPE CONSOLE}

uses
  Vcl.Forms,
  System.SysUtils,
  System.JSON,
  dm_user in '..\..\Program\DataModules\dm_user.pas' {DMUser: TDataModule},
  unit_MCP_Transport in 'unit_MCP_Transport.pas',
  unit_MCP_Protocol in 'unit_MCP_Protocol.pas',
  unit_MCP_Json in 'unit_MCP_Json.pas',
  unit_MCP_Tools_Library in 'unit_MCP_Tools_Library.pas';

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
