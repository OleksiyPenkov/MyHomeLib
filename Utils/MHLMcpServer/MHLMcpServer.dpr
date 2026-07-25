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

var
  Server: TMcpServer;

begin
  Application.Initialize;

  DMUser := TDMUser.Create(nil);
  try
    DMUser.Init;

    Server := TMcpServer.Create;
    try
      // echo_args is a temporary diagnostic tool from Task 3, removed in Task 10.
      Server.RegisterTool('echo_args', 'Test helper', TJSONObject.Create,
        function(const Args: TJSONObject): TJSONObject
        var
          Limit: Integer;
          Clamped: Boolean;
        begin
          Limit := ArgIntClamped(Args, 'limit', 25, 1, 200, Clamped);
          Result := TJSONObject.Create;
          Result.AddPair('limit', TJSONNumber.Create(Limit));
          Result.AddPair('clamped', TJSONBool.Create(Clamped));
        end);

      RegisterLibraryTools(Server);
      Server.Run;
    finally
      Server.Free;
    end;
  finally
    DMUser.Free;
  end;
end.
