(* *****************************************************************************
  *
  * MyHomeLib
  *
  * Copyright (C) 2008-2023 Oleksiy Penkov (aka Koreec)
  *
  * Author(s)           Nick Rymanov (nrymanov@gmail.com)
  * Created             13.07.2010
  * Description         
  *
  * $Id: unit_xmlUtils.pas 1064 2011-09-02 11:33:04Z eg_ $
  *
  * History
  *
  ****************************************************************************** *)

unit unit_xmlUtils;

interface

uses
  Classes,
  SysUtils,
  msxml,
  msxmldom,
  xmldom,
  XMLConst;

type
  TMSXMLHelper = class
  private
    class function newDocument: IXMLDOMDocument;

  public
    class function CreateEmptyDocument: IXMLDOMDocument;
    class function LoadFromZFile(const FileName: string): IXMLDOMDocument;
    class procedure SaveToZFile(xmlDoc: IXMLDOMDocument; const FileName: string);
  end;

  EMSXMLParseError = class(Exception)
  private
    FParseError: IXMLDOMParseError;
    function GetFilePos: Integer;
    function GetLine: Integer;
    function GetLinePos: Integer;
    function GetReason: DOMString;
    function GetSrcText: DOMString;
    function GetURL: DOMString;
    function GetErrorCode: Integer;

  protected
    property ParseError: IXMLDOMParseError read FParseError;

  public
    constructor Create(const ParseError: IXMLDOMParseError; const Msg: string);

    property ErrorCode: Integer read GetErrorCode;
    property URL: DOMString read GetURL;
    property Reason: DOMString read GetReason;
    property SrcText: DOMString read GetSrcText;
    property Line: Integer read GetLine;
    property LinePos: Integer read GetLinePos;
    property FilePos: Integer read GetFilePos;
  end;

implementation

uses
  Variants,
  ActiveX,
  ZLib;

{ TMSXMLHelper }

class function TMSXMLHelper.LoadFromZFile(const FileName: string): IXMLDOMDocument;
var
  fileStream: TFileStream;
  zipStream: TZDecompressionStream;
  vIn: OleVariant;
  xmlDoc: IXMLDOMDocument;
  ParseError: IXMLDOMParseError;
  Msg: string;
begin
  fileStream := TFileStream.Create(FileName, fmOpenRead);
  try
    zipStream := TZDecompressionStream.Create(fileStream);
    try
      vIn := TStreamAdapter.Create(zipStream) as IStream;
      try
        xmlDoc := newDocument;

        if not xmlDoc.load(vIn) then
        begin
          ParseError := xmlDoc.parseError;
          Msg := Format(
            '%s%s%s: %d%s%s',
            [
              ParseError.reason, SLineBreak,
              SLine, ParseError.line, SLineBreak,
              Copy(ParseError.srcText, 1, 40)
            ]
          );
          raise EMSXMLParseError.Create(ParseError, Msg);
        end;

        Result := xmlDoc;
      finally
        vIn := Unassigned;
      end;
    finally
      zipStream.Free;
    end;
  finally
    fileStream.Free;
  end;
end;

class function TMSXMLHelper.newDocument: IXMLDOMDocument;
begin
  Result := msxmldom.CreateDOMDocument;
  Result.async := False;
end;

class function TMSXMLHelper.CreateEmptyDocument: IXMLDOMDocument;
begin
  Result := newDocument;

  // Create a processing instruction targeted for xml.
  Result.appendChild(Result.createProcessingInstruction('xml', 'version="1.0" encoding="UTF-8"'));
end;

class procedure TMSXMLHelper.SaveToZFile(xmlDoc: IXMLDOMDocument; const FileName: string);
var
  fileStream: TFileStream;
  zipStream: TZCompressionStream;
  vOut: OleVariant;
begin
  fileStream := TFileStream.Create(FileName, fmCreate);
  try
    zipStream := TZCompressionStream.Create(fileStream);
    try
      vOut := TStreamAdapter.Create(zipStream) as IStream;
      try
        xmlDoc.save(vOut);
      finally
        vOut := Unassigned;
      end;
    finally
      zipStream.Free;
    end;
  finally
    fileStream.Free;
  end;
end;

{ EMSXMLParseError }

constructor EMSXMLParseError.Create(const ParseError: IXMLDOMParseError; const Msg: string);
begin
  FParseError := ParseError;
  inherited Create(Msg);
end;

function EMSXMLParseError.GetErrorCode: Integer;
begin
  Result := ParseError.errorCode;
end;

function EMSXMLParseError.GetFilePos: Integer;
begin
  Result := ParseError.filepos;
end;

function EMSXMLParseError.GetLine: Integer;
begin
  Result := ParseError.line;
end;

function EMSXMLParseError.GetLinePos: Integer;
begin
  Result := ParseError.linepos;
end;

function EMSXMLParseError.GetReason: DOMString;
begin
  Result := ParseError.reason;
end;

function EMSXMLParseError.GetSrcText: DOMString;
begin
  Result := ParseError.srcText;
end;

function EMSXMLParseError.GetURL: DOMString;
begin
  Result := ParseError.url;
end;

end.
