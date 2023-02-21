(* *****************************************************************************
  *
  * MyHomeLib
  *
  * Copyright (C) 2008-2023 Oleksiy Penkov (aka Koreec)
  *
  * Author(s)           Nick Rymanov (nrymanov@gmail.com)
  * Created             30.06.2010
  * Description         
  *
  * $Id: unit_SearchPresets.pas 1064 2011-09-02 11:33:04Z eg_ $
  *
  *
  * History
  *
  ****************************************************************************** *)

unit unit_SearchPresets;

interface

uses
  msxml,
  ComObj,
  Generics.Collections;

type
  TSearchPreset = class(TDictionary<string, string>)
  strict private
    FDisplayName: string;

  public
    constructor Create(const DisplayName: string);
    destructor Destroy; override;

    property DisplayName: string read FDisplayName;
  end;

  TSearchPresets = class(TObjectList<TSearchPreset>)
  strict private
    function PresetByName(const presetName: string): Integer;

  public
    constructor Create;
    destructor Destroy; override;

    procedure Load(const FileName: string);
    procedure Save(const FileName: string);

    function GetPreset(const presetName: string): TSearchPreset;
    procedure RemovePreset(const presetName: string);
  end;

implementation

uses
  msxmldom,
  XMLConst,
  SysUtils,
  unit_xmlUtils;

resourcestring
  rstrInvalidPresetName = 'Неверное название пресета';

const
  PRESETS_ELEMENT = 'Presets';
  PRESET_ELEMENT = 'Preset';
  FIELD_ELEMENT = 'Field';
  DISPLAYNAME_ATTRIBUTE = 'displayName';

{ TSearchPreset }

constructor TSearchPreset.Create(const DisplayName: string);
begin
  inherited Create;
  FDisplayName := DisplayName;
end;

destructor TSearchPreset.Destroy;
begin
  inherited;
end;

{ TSearchPresets }

constructor TSearchPresets.Create;
begin
  inherited Create(True);
end;

destructor TSearchPresets.Destroy;
begin
  inherited;
end;

procedure TSearchPresets.Load(const FileName: string);
var
  xmlDoc : IXMLDOMDocument;
  xmlPresets: IXMLDOMNodeList;
  xmlPreset: IXMLDOMNode;
  xmlFields: IXMLDOMNodeList;
  xmlField: IXMLDOMNode;
  preset: TSearchPreset;
begin
  xmlDoc := TMSXMLHelper.LoadFromZFile(FileName);

  xmlPresets := xmlDoc.selectNodes('/' + PRESETS_ELEMENT + '/' + PRESET_ELEMENT);
  xmlPreset := xmlPresets.nextNode;
  while Assigned(xmlPreset) do
  begin
    preset := GetPreset(xmlPreset.attributes.getNamedItem(DISPLAYNAME_ATTRIBUTE).text);

    xmlFields := xmlPreset.selectNodes(FIELD_ELEMENT);
    xmlField := xmlFields.nextNode;
    while Assigned(xmlField) do
    begin
      preset.AddOrSetValue(xmlField.attributes.getNamedItem(DISPLAYNAME_ATTRIBUTE).Text, xmlField.Text);

      xmlField := xmlFields.nextNode;
    end;

    xmlPreset := xmlPresets.nextNode;
  end;
end;

procedure TSearchPresets.Save(const FileName: string);
var
  xmlDoc : IXMLDOMDocument;
  xmlPresets: IXMLDOMElement;
  i: Integer;
  preset: TSearchPreset;
  xmlPreset: IXMLDOMElement;
  xmlField: IXMLDOMElement;
  xmlValue: IXMLDOMCDATASection;
  presetField: TPair<string, string>;
begin
  xmlDoc := TMSXMLHelper.CreateEmptyDocument;

  // Create the root element (i.e., the documentElement).
  xmlPresets := xmlDoc.createElement(PRESETS_ELEMENT);
  xmlDoc.appendChild(xmlPresets);

  for i := 0 to Count - 1 do
  begin
    preset := Items[i];

    xmlPreset := xmlDoc.createElement(PRESET_ELEMENT);
    xmlPreset.setAttribute(DISPLAYNAME_ATTRIBUTE, preset.DisplayName);

    for presetField in preset do
    begin
      xmlField := xmlDoc.createElement(FIELD_ELEMENT);
      xmlField.setAttribute(DISPLAYNAME_ATTRIBUTE, presetField.Key);

      xmlValue := xmlDoc.createCDATASection(presetField.Value);
      xmlField.appendChild(xmlValue);

      xmlPreset.appendChild(xmlField);
    end;

    xmlPresets.appendChild(xmlPreset);
  end;

  TMSXMLHelper.SaveToZFile(xmlDoc, FileName);
end;

function TSearchPresets.PresetByName(const presetName: string): Integer;
var
  i: Integer;
begin
  for i := 0 to Count - 1 do
  begin
    if Items[i].DisplayName = presetName then
    begin
      Result := i;
      Exit;
    end;
  end;
  Result := -1;
end;

function TSearchPresets.GetPreset(const presetName: string): TSearchPreset;
var
  i: Integer;
begin
  Assert(presetName <> '');

  if presetName = '' then
    raise EArgumentException.Create(rstrInvalidPresetName);

  i := PresetByName(presetName);
  if i = -1 then
  begin
    Result := TSearchPreset.Create(presetName);
    Add(Result);
  end
  else
    Result := Items[i];
end;

procedure TSearchPresets.RemovePreset(const presetName: string);
var
  i: Integer;
begin
  i := PresetByName(presetName);
  if i <> -1 then
    Delete(i);
end;

end.
