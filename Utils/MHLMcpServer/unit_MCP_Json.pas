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

// ArgStr/ArgInt/ArgBool used to call TJSONValue's *defaulting* GetValue<T>
// overload (GetValue<T>(Name, Default)), which internally calls
// TryGetValue<T> and falls back to Default on ANY failure -- an ABSENT
// argument and a PRESENT-but-wrong-typed one were indistinguishable to the
// caller, both silently producing Default. Measured against the real
// collection: search_books{title:{"a":1}} (an object where a string was
// documented) returned total_count: 439393 -- the whole non-deleted
// collection -- because the swallowed type mismatch left Criteria.Title
// empty, the same "silently becomes no filter" shape as an absent title --
// not an error a caller (usually an LLM) has any way to notice.
// include_deleted:"yes" silently became False; limit:"abc" silently became
// 25 with no "clamped" flag -- every one of these is a malformed call
// answered with a confidently wrong result instead of invalid_params.
//
// Fixed the same way RequireInt already handled this for required integers:
// distinguish "absent" (Args.GetValue(Name) = nil -- the key is not in the
// object at all) from "present", and only default on the former. A present
// value goes through the strict, non-defaulting GetValue<T>(Name) overload,
// which raises EJSONException on a genuine type mismatch; that is mapped to
// EMcpToolError('invalid_params', ...) naming the argument, exactly like
// RequireInt's own except block.
//
// Note on coercion: the RTL's own TJSONValue.AsTValue/StrToTValue performs
// some conversions before failing outright -- a JSON string that parses as a
// number (e.g. "42") still succeeds as an Integer argument, and a JSON
// number still succeeds as a String argument (rendered as its decimal text).
// That coercion is inherited from GetValue<T> itself (RequireInt already
// exhibited it for required integers) and is left alone here for
// consistency between all four helpers -- only an outright-incompatible
// value (an object/array where a scalar is expected, a non-numeric string
// for an integer, a non-"true"/"false"-shaped string for a boolean) raises.
function ArgStr(const Args: TJSONObject; const Name: string; const Default: string): string;
begin
  if (not Assigned(Args)) or (Args.GetValue(Name) = nil) then
    Exit(Default);
  try
    Result := Args.GetValue<string>(Name);
  except
    on E: EJSONException do
      raise EMcpToolError.Create('invalid_params',
        Format('Argument %s must be a string', [Name]));
  end;
end;

function ArgInt(const Args: TJSONObject; const Name: string; Default: Integer): Integer;
begin
  if (not Assigned(Args)) or (Args.GetValue(Name) = nil) then
    Exit(Default);
  try
    Result := Args.GetValue<Integer>(Name);
  except
    on E: EJSONException do
      raise EMcpToolError.Create('invalid_params',
        Format('Argument %s must be an integer', [Name]));
  end;
end;

function ArgBool(const Args: TJSONObject; const Name: string; Default: Boolean): Boolean;
begin
  if (not Assigned(Args)) or (Args.GetValue(Name) = nil) then
    Exit(Default);
  try
    Result := Args.GetValue<Boolean>(Name);
  except
    on E: EJSONException do
      raise EMcpToolError.Create('invalid_params',
        Format('Argument %s must be a boolean', [Name]));
  end;
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
