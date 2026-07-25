unit unit_MCP_Transport;

interface

uses
  Winapi.Windows,
  System.Classes,
  System.SysUtils;

type
  // Newline-delimited UTF-8 JSON over the process's standard handles.
  // This is the ONLY class in the project permitted to write to stdout.
  TMcpTransport = class
  private
    FInput: THandleStream;
    FOutput: THandleStream;
    FPending: TBytes;
    FPendingLen: Integer;
    function TakeLine(out Line: string): Boolean;
  public
    constructor Create;
    destructor Destroy; override;

    // Blocks until a full line arrives. False means stdin reached EOF.
    function ReadMessage(out Msg: string): Boolean;
    procedure WriteMessage(const Msg: string);
  end;

implementation

const
  CHUNK_SIZE = 8192;

constructor TMcpTransport.Create;
begin
  inherited Create;
  FInput := THandleStream.Create(GetStdHandle(STD_INPUT_HANDLE));
  FOutput := THandleStream.Create(GetStdHandle(STD_OUTPUT_HANDLE));
  SetLength(FPending, CHUNK_SIZE);
  FPendingLen := 0;
end;

destructor TMcpTransport.Destroy;
begin
  FInput.Free;
  FOutput.Free;
  inherited Destroy;
end;

function TMcpTransport.TakeLine(out Line: string): Boolean;
var
  I, LineLen, Rest: Integer;
begin
  Result := False;
  Line := '';

  for I := 0 to FPendingLen - 1 do
    if FPending[I] = 10 then // LF
    begin
      LineLen := I;
      if (LineLen > 0) and (FPending[LineLen - 1] = 13) then // strip CR
        Dec(LineLen);

      Line := TEncoding.UTF8.GetString(FPending, 0, LineLen);

      Rest := FPendingLen - I - 1;
      if Rest > 0 then
        Move(FPending[I + 1], FPending[0], Rest);
      FPendingLen := Rest;

      Exit(True);
    end;
end;

function TMcpTransport.ReadMessage(out Msg: string): Boolean;
var
  Got: Integer;
begin
  if TakeLine(Msg) then
    Exit(True);

  repeat
    if FPendingLen + CHUNK_SIZE > Length(FPending) then
      SetLength(FPending, Length(FPending) * 2);

    Got := FInput.Read(FPending[FPendingLen], CHUNK_SIZE);
    if Got <= 0 then
      Exit(False); // EOF: the client closed the pipe

    Inc(FPendingLen, Got);

    if TakeLine(Msg) then
      Exit(True);
  until False;
end;

procedure TMcpTransport.WriteMessage(const Msg: string);
var
  Data: TBytes;
  LF: Byte;
begin
  Data := TEncoding.UTF8.GetBytes(Msg);
  if Length(Data) > 0 then
    FOutput.WriteBuffer(Data[0], Length(Data));
  LF := 10;
  FOutput.WriteBuffer(LF, 1);
end;

end.
