unit unit_MCP_Json;

interface

uses
  System.SysUtils,
  System.JSON,
  unit_MCP_Protocol;

function ArgStr(const Args: TJSONObject; const Name: string; const Default: string = ''): string;
function ArgInt(const Args: TJSONObject; const Name: string; Default: Integer): Integer;
function ArgBool(const Args: TJSONObject; const Name: string; Default: Boolean): Boolean;
function ArgIntClamped(const Args: TJSONObject; const Name: string;
  Default, Min, Max: Integer; out Clamped: Boolean): Integer;
function RequireInt(const Args: TJSONObject; const Name: string): Integer;

implementation

function ArgStr(const Args: TJSONObject; const Name: string; const Default: string): string;
begin
  if not Assigned(Args) then
    Exit(Default);
  Result := Args.GetValue<string>(Name, Default);
end;

function ArgInt(const Args: TJSONObject; const Name: string; Default: Integer): Integer;
begin
  if not Assigned(Args) then
    Exit(Default);
  Result := Args.GetValue<Integer>(Name, Default);
end;

function ArgBool(const Args: TJSONObject; const Name: string; Default: Boolean): Boolean;
begin
  if not Assigned(Args) then
    Exit(Default);
  Result := Args.GetValue<Boolean>(Name, Default);
end;

function ArgIntClamped(const Args: TJSONObject; const Name: string;
  Default, Min, Max: Integer; out Clamped: Boolean): Integer;
begin
  Result := ArgInt(Args, Name, Default);
  Clamped := False;

  if Result < Min then
  begin
    Result := Min;
    Clamped := True;
  end
  else if Result > Max then
  begin
    Result := Max;
    Clamped := True;
  end;
end;

function RequireInt(const Args: TJSONObject; const Name: string): Integer;
begin
  if (not Assigned(Args)) or (Args.GetValue(Name) = nil) then
    raise EMcpToolError.Create('invalid_params',
      Format('Missing required argument: %s', [Name]));
  try
    Result := Args.GetValue<Integer>(Name);
  except
    on E: EJSONException do
      raise EMcpToolError.Create('invalid_params',
        Format('Argument %s must be an integer', [Name]));
  end;
end;

end.
