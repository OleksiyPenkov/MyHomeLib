program MHLMcpServer;

{$APPTYPE CONSOLE}

uses
  System.SysUtils,
  System.JSON,
  unit_MCP_Transport in 'unit_MCP_Transport.pas';

// IMPORTANT: nothing in this project may write to stdout except TMcpTransport.
// A single stray WriteLn corrupts every JSON-RPC response.

var
  Transport: TMcpTransport;
  Line: string;
  Request, Response: TJSONObject;

begin
  Transport := TMcpTransport.Create;
  try
    while Transport.ReadMessage(Line) do
    begin
      if Trim(Line) = '' then
        Continue;

      Request := TJSONObject.ParseJSONValue(Line) as TJSONObject;
      if not Assigned(Request) then
        Continue;
      try
        if Request.GetValue<string>('method', '') = 'ping' then
        begin
          Response := TJSONObject.Create;
          try
            Response.AddPair('jsonrpc', '2.0');
            Response.AddPair('id', Request.GetValue('id').Clone as TJSONValue);
            Response.AddPair('result', TJSONObject.Create);
            Transport.WriteMessage(Response.ToJSON);
          finally
            Response.Free;
          end;
        end;
      finally
        Request.Free;
      end;
    end;
  finally
    Transport.Free;
  end;
end.
