(* *****************************************************************************
  *
  * MyHomeLib
  *
  * Copyright (C) 2008-2023 Oleksiy Penkov (aka Koreec)
  *
  * Author(s)           Nick Rymanov     nrymanov@gmail.com
  * Created
  * Description         Строка редактирования с поддержкой автокомплита
  *
  * $Id: unit_AutoCompleteEdit.pas 785 2010-09-17 09:06:06Z nrymanov@gmail.com $
  *
  * History
  *
  ****************************************************************************** *)

unit unit_AutoCompleteEdit;

interface

uses
  Windows, SysUtils, Classes, Controls, StdCtrls, ComObj, ShLwApi;

type
  TAutoCompleteOption = (
    acoFileSystem,
    acoURLHistory,
    acoURLMRU,
    acoUseTab,
    acoFileSysOnly,
    acoAutoSuggestForceOn,
    acoAutoSuggestForceOff,
    acoAutoAppendForceOn,
    acoAutoAppendForceOff
  );

  TAutoCompleteOptions = set of TAutoCompleteOption;

  TMHLAutoCompleteEdit = class(TEdit)
  private
    FAutoComplete: Boolean;
    FAutoCompleteOptions: TAutoCompleteOptions;
    procedure SetAutoComplete(const Value: Boolean);
    procedure SetAutoCompleteOptions(const Value: TAutoCompleteOptions);

    function GetACFlags: DWORD;

  protected
    procedure CreateWnd; override;

  public
    constructor Create(AOwner: TComponent); override;

  published
    property AutoComplete: Boolean read FAutoComplete write SetAutoComplete default True;
    property AutoCompleteOption: TAutoCompleteOptions read FAutoCompleteOptions write SetAutoCompleteOptions default [];
  end;

implementation

{ TMHLAutoCompleteEdit }

constructor TMHLAutoCompleteEdit.Create(AOwner: TComponent);
begin
  inherited;
  FAutoComplete := True;
  FAutoCompleteOptions := [];
end;

function TMHLAutoCompleteEdit.GetACFlags: DWORD;
const
  ACOptions: array [TAutoCompleteOption] of DWORD = (
    SHACF_FILESYSTEM,
    SHACF_URLHISTORY,
    SHACF_URLMRU,
    SHACF_USETAB,
    SHACF_FILESYS_ONLY,
    SHACF_AUTOSUGGEST_FORCE_ON,
    SHACF_AUTOSUGGEST_FORCE_OFF,
    SHACF_AUTOAPPEND_FORCE_ON,
    SHACF_AUTOAPPEND_FORCE_OFF
  );
var
  Option: TAutoCompleteOption;
begin
  if FAutoCompleteOptions = [] then
  begin
    Result := SHACF_DEFAULT;
    Exit;
  end;

  Result := 0;
  for Option := Low(Option) to High(Option) do
    if Option in FAutoCompleteOptions then
      Result := Result or ACOptions[Option];
end;

procedure TMHLAutoCompleteEdit.CreateWnd;
begin
  inherited;

  if FAutoComplete then
  begin
    SHAutoComplete(Handle, GetACFlags);
  end;
end;

procedure TMHLAutoCompleteEdit.SetAutoComplete(const Value: Boolean);
begin
  if FAutoComplete <> Value then
  begin
    FAutoComplete := Value;
    RecreateWnd;
  end;
end;

procedure TMHLAutoCompleteEdit.SetAutoCompleteOptions(const Value: TAutoCompleteOptions);
begin
  if FAutoCompleteOptions <> Value then
  begin
    FAutoCompleteOptions := Value;
    RecreateWnd;
  end;
end;

end.

