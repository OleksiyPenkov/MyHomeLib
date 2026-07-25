unit unit_MCP_Protocol;

interface

uses
  System.SysUtils,
  System.Generics.Collections,
  System.JSON,
  unit_MCP_Transport;

const
  PROTOCOL_VERSION = '2025-06-18';
  SERVER_NAME      = 'myhomelib';
  SERVER_VERSION   = '1.0.0';

  JSONRPC_METHOD_NOT_FOUND = -32601;
  JSONRPC_INVALID_PARAMS   = -32602;
  JSONRPC_INTERNAL_ERROR   = -32603;

type
  // A domain fault. Surfaces as a tool result with isError=true and a
  // machine-readable code, NOT as a JSON-RPC error.
  EMcpToolError = class(Exception)
  private
    FCode: string;
  public
    constructor Create(const ACode, AMessage: string);
    property Code: string read FCode;
  end;

  TMcpToolHandler = reference to function(const Args: TJSONObject): TJSONObject;

  TMcpTool = record
    Name: string;
    Description: string;
    Schema: TJSONObject;   // owned by TMcpServer
    Handler: TMcpToolHandler;
  end;

  TMcpServer = class
  private
    FTransport: TMcpTransport;
    FTools: TList<TMcpTool>;
    function FindTool(const Name: string; out Tool: TMcpTool): Boolean;
    function HandleInitialize(const Params: TJSONObject): TJSONObject;
    function HandleToolsList: TJSONObject;
    function HandleToolsCall(const Params: TJSONObject): TJSONObject;
    procedure SendResult(Id: TJSONValue; Payload: TJSONObject);
    procedure SendError(Id: TJSONValue; Code: Integer; const Msg: string);
    procedure DispatchRequest(const Request: TJSONObject);
  public
    constructor Create;
    destructor Destroy; override;
    procedure RegisterTool(const Name, Description: string; Schema: TJSONObject;
      Handler: TMcpToolHandler);
    procedure Run;
  end;

implementation

constructor EMcpToolError.Create(const ACode, AMessage: string);
begin
  inherited Create(AMessage);
  FCode := ACode;
end;

constructor TMcpServer.Create;
begin
  inherited Create;
  FTransport := TMcpTransport.Create;
  FTools := TList<TMcpTool>.Create;
end;

destructor TMcpServer.Destroy;
var
  Tool: TMcpTool;
begin
  for Tool in FTools do
    Tool.Schema.Free;
  FTools.Free;
  FTransport.Free;
  inherited Destroy;
end;

procedure TMcpServer.RegisterTool(const Name, Description: string;
  Schema: TJSONObject; Handler: TMcpToolHandler);
var
  Tool: TMcpTool;
begin
  Tool.Name := Name;
  Tool.Description := Description;
  Tool.Schema := Schema;
  Tool.Handler := Handler;
  FTools.Add(Tool);
end;

function TMcpServer.FindTool(const Name: string; out Tool: TMcpTool): Boolean;
var
  Candidate: TMcpTool;
begin
  for Candidate in FTools do
    if Candidate.Name = Name then
    begin
      Tool := Candidate;
      Exit(True);
    end;
  Result := False;
end;

function TMcpServer.HandleInitialize(const Params: TJSONObject): TJSONObject;
var
  Version: string;
  Caps, Info: TJSONObject;
begin
  Version := PROTOCOL_VERSION;
  if Assigned(Params) then
    Version := Params.GetValue<string>('protocolVersion', PROTOCOL_VERSION);

  Caps := TJSONObject.Create;
  Caps.AddPair('tools', TJSONObject.Create);

  Info := TJSONObject.Create;
  Info.AddPair('name', SERVER_NAME);
  Info.AddPair('version', SERVER_VERSION);

  Result := TJSONObject.Create;
  Result.AddPair('protocolVersion', Version);
  Result.AddPair('capabilities', Caps);
  Result.AddPair('serverInfo', Info);
end;

function TMcpServer.HandleToolsList: TJSONObject;
var
  Arr: TJSONArray;
  Tool: TMcpTool;
  Entry: TJSONObject;
begin
  Arr := TJSONArray.Create;
  for Tool in FTools do
  begin
    Entry := TJSONObject.Create;
    Entry.AddPair('name', Tool.Name);
    Entry.AddPair('description', Tool.Description);
    Entry.AddPair('inputSchema', Tool.Schema.Clone as TJSONObject);
    Arr.AddElement(Entry);
  end;

  Result := TJSONObject.Create;
  Result.AddPair('tools', Arr);
end;

function TMcpServer.HandleToolsCall(const Params: TJSONObject): TJSONObject;
var
  Tool: TMcpTool;
  ToolName: string;
  Args, Payload, ErrObj: TJSONObject;
  Content: TJSONArray;
  Block: TJSONObject;
  IsError: Boolean;
  Text: string;
begin
  if not Assigned(Params) then
    raise EArgumentException.Create('Missing params');

  ToolName := Params.GetValue<string>('name', '');
  if not FindTool(ToolName, Tool) then
    raise EArgumentException.CreateFmt('Unknown tool: %s', [ToolName]);

  Args := Params.GetValue('arguments') as TJSONObject; // may be nil

  IsError := False;
  Payload := nil;
  try
    Payload := Tool.Handler(Args);
    Text := Payload.ToJSON;
  except
    on E: EMcpToolError do
    begin
      IsError := True;
      ErrObj := TJSONObject.Create;
      try
        ErrObj.AddPair('code', E.Code);
        ErrObj.AddPair('message', E.Message);
        Text := ErrObj.ToJSON;
      finally
        ErrObj.Free;
      end;
    end;
  end;
  Payload.Free;

  Block := TJSONObject.Create;
  Block.AddPair('type', 'text');
  Block.AddPair('text', Text);

  Content := TJSONArray.Create;
  Content.AddElement(Block);

  Result := TJSONObject.Create;
  Result.AddPair('content', Content);
  if IsError then
    Result.AddPair('isError', TJSONBool.Create(True));
end;

procedure TMcpServer.SendResult(Id: TJSONValue; Payload: TJSONObject);
var
  Response: TJSONObject;
begin
  Response := TJSONObject.Create;
  try
    Response.AddPair('jsonrpc', '2.0');
    Response.AddPair('id', Id.Clone as TJSONValue);
    Response.AddPair('result', Payload);
    FTransport.WriteMessage(Response.ToJSON);
  finally
    Response.Free;
  end;
end;

procedure TMcpServer.SendError(Id: TJSONValue; Code: Integer; const Msg: string);
var
  Response, ErrObj: TJSONObject;
begin
  ErrObj := TJSONObject.Create;
  ErrObj.AddPair('code', TJSONNumber.Create(Code));
  ErrObj.AddPair('message', Msg);

  Response := TJSONObject.Create;
  try
    Response.AddPair('jsonrpc', '2.0');
    Response.AddPair('id', Id.Clone as TJSONValue);
    Response.AddPair('error', ErrObj);
    FTransport.WriteMessage(Response.ToJSON);
  finally
    Response.Free;
  end;
end;

procedure TMcpServer.DispatchRequest(const Request: TJSONObject);
var
  Method: string;
  Id: TJSONValue;
  Params: TJSONObject;
begin
  Method := Request.GetValue<string>('method', '');
  Id := Request.GetValue('id'); // nil for notifications
  Params := Request.GetValue('params') as TJSONObject;

  // Notifications never get a response.
  if not Assigned(Id) then
    Exit;

  try
    if Method = 'initialize' then
      SendResult(Id, HandleInitialize(Params))
    else if Method = 'ping' then
      SendResult(Id, TJSONObject.Create)
    else if Method = 'tools/list' then
      SendResult(Id, HandleToolsList)
    else if Method = 'tools/call' then
      SendResult(Id, HandleToolsCall(Params))
    else
      SendError(Id, JSONRPC_METHOD_NOT_FOUND, 'Method not found: ' + Method);
  except
    on E: EArgumentException do
      SendError(Id, JSONRPC_INVALID_PARAMS, E.Message);
    on E: Exception do
      SendError(Id, JSONRPC_INTERNAL_ERROR, E.Message);
  end;
end;

procedure TMcpServer.Run;
var
  Line: string;
  Request: TJSONObject;
begin
  while FTransport.ReadMessage(Line) do
  begin
    if Trim(Line) = '' then
      Continue;

    Request := TJSONObject.ParseJSONValue(Line) as TJSONObject;
    if not Assigned(Request) then
      Continue;
    try
      DispatchRequest(Request);
    finally
      Request.Free;
    end;
  end;
end;

end.
