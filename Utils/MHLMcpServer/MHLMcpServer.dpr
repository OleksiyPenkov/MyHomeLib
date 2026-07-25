program MHLMcpServer;

{$APPTYPE CONSOLE}

uses
  System.SysUtils,
  System.JSON,
  unit_MCP_Transport in 'unit_MCP_Transport.pas',
  unit_MCP_Protocol in 'unit_MCP_Protocol.pas',
  unit_MCP_Json in 'unit_MCP_Json.pas';

// IMPORTANT: nothing in this project may write to stdout except TMcpTransport.
// A single stray WriteLn corrupts every JSON-RPC response.

var
  Server: TMcpServer;

begin
  Server := TMcpServer.Create;
  try
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
    Server.Run;
  finally
    Server.Free;
  end;
end.
