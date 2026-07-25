program MHLMcpServer;

{$APPTYPE CONSOLE}

uses
  System.SysUtils,
  unit_MCP_Transport in 'unit_MCP_Transport.pas',
  unit_MCP_Protocol in 'unit_MCP_Protocol.pas';

// IMPORTANT: nothing in this project may write to stdout except TMcpTransport.
// A single stray WriteLn corrupts every JSON-RPC response.

var
  Server: TMcpServer;

begin
  Server := TMcpServer.Create;
  try
    Server.Run;
  finally
    Server.Free;
  end;
end.
