(* *****************************************************************************
  *
  * FictionBook 2.1
  *
  * Copyright (c) Alex Sedykh alexs@vsi.ru
  *
  * Author(s)
  * Created                  12.10.2009
  * Description
  *
  * $Id: fictionbook_21.pas 1064 2011-09-02 11:33:04Z eg_ $
  *
  * History
  * Alex Penkov              multy-p in the annotation added
  *
  ****************************************************************************** *)

unit fictionbook_21;

interface

uses xmldom, XMLDoc, XMLIntf, Classes;

type

{ Forward Decls }

  IXMLFictionBook = interface;
  IXMLStylesheet = interface;
  IXMLStylesheetList = interface;
  IXMLDescription = interface;
  IXMLTitleinfoType = interface;
  IXMLAuthorType = interface;
  IXMLAuthorTypeList = interface;
  IXMLTextFieldType = interface;
  IXMLAnnotationType = interface;
  IXMLStyleType = interface;
  IXMLPoemType = interface;
  IXMLTitleType = interface;
  IXMLEpigraphType = interface;
  IXMLEpigraphTypeList = interface;
  IXMLCiteType = interface;
  IXMLTableType = interface;
  IXMLTr = interface;
  IXMLStanza = interface;
  IXMLStanzaList = interface;
  IXMLDateType = interface;
  IXMLCoverpage = interface;
  IXMLImageType = interface;
  IXMLSequenceType = interface;
  IXMLSequenceTypeList = interface;
  IXMLDocumentinfo = interface;
  IXMLPublishinfo = interface;
  IXMLCustominfo = interface;
  IXMLCustominfoList = interface;
  IXMLShareInstructionType = interface;
  IXMLShareInstructionTypeList = interface;
  IXMLPartShareInstructionType = interface;
  IXMLPartShareInstructionTypeList = interface;
  IXMLOutPutDocumentType = interface;
  IXMLOutPutDocumentTypeList = interface;
  IXMLBody = interface;
  IXMLBodyList = interface;
  IXMLSectionType = interface;
  IXMLSectionTypeList = interface;
  IXMLBinary = interface;
  IXMLBinaryList = interface;
  IXMLPType = interface;
  IXMLPTypeList = interface;
  IXMLNamedStyleType = interface;
  IXMLLinkType = interface;
  IXMLStyleLinkType = interface;
  IXMLGenreTypeList = interface;
  IXMLString_List = interface;

{ IXMLFictionBook }

  IXMLFictionBook = interface(IXMLNode)
    ['{8DC85ACE-5E51-4F13-A552-C55AC0B521C7}']
    { Property Accessors }
    function Get_Stylesheet: IXMLStylesheetList;
    function Get_Description: IXMLDescription;
    function Get_Body: IXMLBodyList;
    function Get_Binary: IXMLBinaryList;
    { Methods & Properties }
    property Stylesheet: IXMLStylesheetList read Get_Stylesheet;
    property Description: IXMLDescription read Get_Description;
    property Body: IXMLBodyList read Get_Body;
    property Binary: IXMLBinaryList read Get_Binary;
  end;

{ IXMLStylesheet }

  IXMLStylesheet = interface(IXMLNode)
    ['{640BE3B5-E791-4BC7-8E51-F0938326953C}']
    { Property Accessors }
    function Get_Type_: WideString;
    procedure Set_Type_(Value: WideString);
    { Methods & Properties }
    property Type_: WideString read Get_Type_ write Set_Type_;
  end;

{ IXMLStylesheetList }

  IXMLStylesheetList = interface(IXMLNodeCollection)
    ['{D019ADC7-C7DB-4C77-8D7D-A895FCA309B9}']
    { Methods & Properties }
    function Add: IXMLStylesheet;
    function Insert(const Index: Integer): IXMLStylesheet;
    function Get_Item(Index: Integer): IXMLStylesheet;
    property Items[Index: Integer]: IXMLStylesheet read Get_Item; default;
  end;

{ IXMLDescription }

  IXMLDescription = interface(IXMLNode)
    ['{D519D90E-7707-4ED9-988D-700C133BA87E}']
    { Property Accessors }
    function Get_Titleinfo: IXMLTitleinfoType;
    function Get_Srctitleinfo: IXMLTitleinfoType;
    function Get_Documentinfo: IXMLDocumentinfo;
    function Get_Publishinfo: IXMLPublishinfo;
    function Get_Custominfo: IXMLCustominfoList;
    function Get_Output: IXMLShareInstructionTypeList;
    { Methods & Properties }
    property Titleinfo: IXMLTitleinfoType read Get_Titleinfo;
    property Srctitleinfo: IXMLTitleinfoType read Get_Srctitleinfo;
    property Documentinfo: IXMLDocumentinfo read Get_Documentinfo;
    property Publishinfo: IXMLPublishinfo read Get_Publishinfo;
    property Custominfo: IXMLCustominfoList read Get_Custominfo;
    property Output: IXMLShareInstructionTypeList read Get_Output;
  end;

{ IXMLTitleinfoType }

  IXMLTitleinfoType = interface(IXMLNode)
    ['{7C5D1F97-C2E2-4360-B73B-585AD706C461}']
    { Property Accessors }
    function Get_Genre: IXMLGenreTypeList;
    function Get_Author: IXMLAuthorTypeList;
    function Get_Booktitle: IXMLTextFieldType;
    function Get_Annotation: IXMLAnnotationType;
    function Get_Keywords: IXMLTextFieldType;
    function Get_Date: IXMLDateType;
    function Get_Coverpage: IXMLCoverpage;
    function Get_Lang: WideString;
    function Get_Srclang: WideString;
    function Get_Translator: IXMLAuthorTypeList;
    function Get_Sequence: IXMLSequenceTypeList;
    procedure Set_Lang(Value: WideString);
    procedure Set_Srclang(Value: WideString);
    { Methods & Properties }
    property Genre: IXMLGenreTypeList read Get_Genre;
    property Author: IXMLAuthorTypeList read Get_Author;
    property Booktitle: IXMLTextFieldType read Get_Booktitle;
    property Annotation: IXMLAnnotationType read Get_Annotation;
    property Keywords: IXMLTextFieldType read Get_Keywords;
    property Date: IXMLDateType read Get_Date;
    property Coverpage: IXMLCoverpage read Get_Coverpage;
    property Lang: WideString read Get_Lang write Set_Lang;
    property Srclang: WideString read Get_Srclang write Set_Srclang;
    property Translator: IXMLAuthorTypeList read Get_Translator;
    property Sequence: IXMLSequenceTypeList read Get_Sequence;
  end;

{ IXMLAuthorType }

  IXMLAuthorType = interface(IXMLNode)
    ['{D9897679-7F0F-4995-9FC3-9A5DCC6EF712}']
    { Property Accessors }
    function Get_Firstname: IXMLTextFieldType;
    function Get_Middlename: IXMLTextFieldType;
    function Get_Lastname: IXMLTextFieldType;
    function Get_Nickname: IXMLTextFieldType;
    function Get_Homepage: IXMLString_List;
    function Get_Email: IXMLString_List;
    { Methods & Properties }
    property Firstname: IXMLTextFieldType read Get_Firstname;
    property Middlename: IXMLTextFieldType read Get_Middlename;
    property Lastname: IXMLTextFieldType read Get_Lastname;
    property Nickname: IXMLTextFieldType read Get_Nickname;
    property Homepage: IXMLString_List read Get_Homepage;
    property Email: IXMLString_List read Get_Email;
  end;

{ IXMLAuthorTypeList }

  IXMLAuthorTypeList = interface(IXMLNodeCollection)
    ['{A57ED11E-EF07-4D5B-9E91-DD5A0B9AD82A}']
    { Methods & Properties }
    function Add: IXMLAuthorType;
    function Insert(const Index: Integer): IXMLAuthorType;
    function Get_Item(Index: Integer): IXMLAuthorType;
    property Items[Index: Integer]: IXMLAuthorType read Get_Item; default;
  end;

{ IXMLTextFieldType }

  IXMLTextFieldType = interface(IXMLNode)
    ['{9D1EF29E-1AD9-4ADF-AA57-D045F0A51DB4}']
    { Property Accessors }
    function Get_xmlLang: WideString;
    procedure Set_xmlLang(Value: WideString);
    { Methods & Properties }
    property xmlLang: WideString read Get_xmlLang write Set_xmlLang;
  end;

{ IXMLAnnotationType }

  IXMLAnnotationType = interface(IXMLNode)
    ['{5074F7AF-4D92-4795-A194-03B2B3B6CF3A}']
    { Property Accessors }
    function Get_Id: WideString;
    function Get_xmlLang: WideString;
    function Get_P: IXMLPTypeList;
    function Get_Poem: IXMLPoemType;
    function Get_Cite: IXMLCiteType;
    function Get_Subtitle: IXMLPType;
    function Get_Table: IXMLTableType;
    function Get_Emptyline: WideString;
    procedure Set_Id(Value: WideString);
    procedure Set_xmlLang(Value: WideString);
    { Methods & Properties }
    property Id: WideString read Get_Id write Set_Id;
    property xmlLang: WideString read Get_xmlLang write Set_xmlLang;
    property P: IXMLPTypeList read Get_P;
    property Poem: IXMLPoemType read Get_Poem;
    property Cite: IXMLCiteType read Get_Cite;
    property Subtitle: IXMLPType read Get_Subtitle;
    property Table: IXMLTableType read Get_Table;
    property Emptyline: WideString read Get_Emptyline;
  end;

{ IXMLStyleType }

  IXMLStyleType = interface(IXMLNode)
    ['{24758A34-A448-4E9E-A818-7D3B37EFE9EA}']
    { Property Accessors }
    function Get_xmlLang: WideString;
    function Get_Strong: IXMLStyleType;
    function Get_Emphasis: IXMLStyleType;
    function Get_Style: IXMLNamedStyleType;
    function Get_A: IXMLLinkType;
    function Get_Strikethrough: IXMLStyleType;
    function Get_Sub: IXMLStyleType;
    function Get_Sup: IXMLStyleType;
    function Get_Code: IXMLStyleType;
    function Get_Image: IXMLImageType;
    procedure Set_xmlLang(Value: WideString);
    { Methods & Properties }
    property xmlLang: WideString read Get_xmlLang write Set_xmlLang;
    property Strong: IXMLStyleType read Get_Strong;
    property Emphasis: IXMLStyleType read Get_Emphasis;
    property Style: IXMLNamedStyleType read Get_Style;
    property A: IXMLLinkType read Get_A;
    property Strikethrough: IXMLStyleType read Get_Strikethrough;
    property Sub: IXMLStyleType read Get_Sub;
    property Sup: IXMLStyleType read Get_Sup;
    property Code: IXMLStyleType read Get_Code;
    property Image: IXMLImageType read Get_Image;
  end;

{ IXMLPoemType }

  IXMLPoemType = interface(IXMLNode)
    ['{22BBDBFB-488C-4997-AEC5-C40EEF60E91E}']
    { Property Accessors }
    function Get_Id: WideString;
    function Get_xmlLang: WideString;
    function Get_Title: IXMLTitleType;
    function Get_Epigraph: IXMLEpigraphTypeList;
    function Get_Stanza: IXMLStanzaList;
    function Get_Textauthor: IXMLPTypeList;
    function Get_Date: IXMLDateType;
    procedure Set_Id(Value: WideString);
    procedure Set_xmlLang(Value: WideString);
    { Methods & Properties }
    property Id: WideString read Get_Id write Set_Id;
    property xmlLang: WideString read Get_xmlLang write Set_xmlLang;
    property Title: IXMLTitleType read Get_Title;
    property Epigraph: IXMLEpigraphTypeList read Get_Epigraph;
    property Stanza: IXMLStanzaList read Get_Stanza;
    property Textauthor: IXMLPTypeList read Get_Textauthor;
    property Date: IXMLDateType read Get_Date;
  end;

{ IXMLTitleType }

  IXMLTitleType = interface(IXMLNode)
    ['{C0C20FCE-79EE-42EC-A1B6-682B30F30FEF}']
    { Property Accessors }
    function Get_xmlLang: WideString;
    function Get_P: IXMLPType;
    function Get_Emptyline: WideString;
    procedure Set_xmlLang(Value: WideString);
    { Methods & Properties }
    property xmlLang: WideString read Get_xmlLang write Set_xmlLang;
    property P: IXMLPType read Get_P;
    property Emptyline: WideString read Get_Emptyline;
  end;

{ IXMLEpigraphType }

  IXMLEpigraphType = interface(IXMLNode)
    ['{52890EC4-0429-4E1D-AF4D-17B38299EA59}']
    { Property Accessors }
    function Get_Id: WideString;
    function Get_P: IXMLPType;
    function Get_Poem: IXMLPoemType;
    function Get_Cite: IXMLCiteType;
    function Get_Emptyline: WideString;
    function Get_Textauthor: IXMLPTypeList;
    procedure Set_Id(Value: WideString);
    { Methods & Properties }
    property Id: WideString read Get_Id write Set_Id;
    property P: IXMLPType read Get_P;
    property Poem: IXMLPoemType read Get_Poem;
    property Cite: IXMLCiteType read Get_Cite;
    property Emptyline: WideString read Get_Emptyline;
    property Textauthor: IXMLPTypeList read Get_Textauthor;
  end;

{ IXMLEpigraphTypeList }

  IXMLEpigraphTypeList = interface(IXMLNodeCollection)
    ['{55352450-EB25-45F8-A4AD-D72115BBD634}']
    { Methods & Properties }
    function Add: IXMLEpigraphType;
    function Insert(const Index: Integer): IXMLEpigraphType;
    function Get_Item(Index: Integer): IXMLEpigraphType;
    property Items[Index: Integer]: IXMLEpigraphType read Get_Item; default;
  end;

{ IXMLCiteType }

  IXMLCiteType = interface(IXMLNode)
    ['{AC0B5281-5DBA-40FD-89E5-213F1A6DBADE}']
    { Property Accessors }
    function Get_Id: WideString;
    function Get_xmlLang: WideString;
    function Get_P: IXMLPType;
    function Get_Poem: IXMLPoemType;
    function Get_Emptyline: WideString;
    function Get_Subtitle: IXMLPType;
    function Get_Table: IXMLTableType;
    function Get_Textauthor: IXMLPTypeList;
    procedure Set_Id(Value: WideString);
    procedure Set_xmlLang(Value: WideString);
    { Methods & Properties }
    property Id: WideString read Get_Id write Set_Id;
    property xmlLang: WideString read Get_xmlLang write Set_xmlLang;
    property P: IXMLPType read Get_P;
    property Poem: IXMLPoemType read Get_Poem;
    property Emptyline: WideString read Get_Emptyline;
    property Subtitle: IXMLPType read Get_Subtitle;
    property Table: IXMLTableType read Get_Table;
    property Textauthor: IXMLPTypeList read Get_Textauthor;
  end;

{ IXMLTableType }

  IXMLTableType = interface(IXMLNodeCollection)
    ['{3E6131C3-5DC9-40CF-9396-B54A04B0DBD0}']
    { Property Accessors }
    function Get_Tr(Index: Integer): IXMLTr;
    { Methods & Properties }
    function Add: IXMLTr;
    function Insert(const Index: Integer): IXMLTr;
    property Tr[Index: Integer]: IXMLTr read Get_Tr; default;
  end;

{ IXMLTr }

  IXMLTr = interface(IXMLNodeCollection)
    ['{DB2FD524-0EF4-4689-BB10-75F084A12D56}']
    { Property Accessors }
    function Get_Align: WideString;
    function Get_Td(Index: Integer): IXMLPTypeList;
    procedure Set_Align(Value: WideString);
    { Methods & Properties }
    function Add: IXMLPType;
    function Insert(const Index: Integer): IXMLPType;
    property Align: WideString read Get_Align write Set_Align;
    property Td[Index: Integer]: IXMLPTypeList read Get_Td; default;
  end;

{ IXMLStanza }

  IXMLStanza = interface(IXMLNode)
    ['{D3AADFC8-A533-4593-959B-28A3FF64AEF1}']
    { Property Accessors }
    function Get_xmlLang: WideString;
    function Get_Title: IXMLTitleType;
    function Get_Subtitle: IXMLPType;
    function Get_V: IXMLPTypeList;
    procedure Set_xmlLang(Value: WideString);
    { Methods & Properties }
    property xmlLang: WideString read Get_xmlLang write Set_xmlLang;
    property Title: IXMLTitleType read Get_Title;
    property Subtitle: IXMLPType read Get_Subtitle;
    property V: IXMLPTypeList read Get_V;
  end;

{ IXMLStanzaList }

  IXMLStanzaList = interface(IXMLNodeCollection)
    ['{8D2B1261-0CDD-4F8F-AAC0-5B7D161337DE}']
    { Methods & Properties }
    function Add: IXMLStanza;
    function Insert(const Index: Integer): IXMLStanza;
    function Get_Item(Index: Integer): IXMLStanza;
    property Items[Index: Integer]: IXMLStanza read Get_Item; default;
  end;

{ IXMLDateType }

  IXMLDateType = interface(IXMLNode)
    ['{279F194D-E4D1-4CBE-BF63-9F5FB7AB80C8}']
    { Property Accessors }
    function Get_Value: WideString;
    function Get_xmlLang: WideString;
    procedure Set_Value(Value: WideString);
    procedure Set_xmlLang(Value: WideString);
    { Methods & Properties }
    property Value: WideString read Get_Value write Set_Value;
    property xmlLang: WideString read Get_xmlLang write Set_xmlLang;
  end;

{ IXMLCoverpage }

  IXMLCoverpage = interface(IXMLNodeCollection)
    ['{516FAAB9-74EA-4851-AB2D-542C3273B7FE}']
    { Property Accessors }
    function Get_ImageList(Index: Integer): IXMLImageType;
    { Methods & Properties }
    function Add: IXMLImageType;
    function Insert(const Index: Integer): IXMLImageType;
    property ImageList[Index: Integer]: IXMLImageType read Get_ImageList; default;
  end;

{ IXMLImageType }

  IXMLImageType = interface(IXMLNode)
    ['{23474124-CFB7-4A70-8429-8FA662FAEDDE}']
    { Property Accessors }
    function Get_xlinkType: WideString;
    function Get_xlinkHref: WideString;
    function Get_Alt: WideString;
    procedure Set_xlinkType(Value: WideString);
    procedure Set_xlinkHref(Value: WideString);
    procedure Set_Alt(Value: WideString);
    { Methods & Properties }
    property xlinkType: WideString read Get_xlinkType write Set_xlinkType;
    property xlinkHref: WideString read Get_xlinkHref write Set_xlinkHref;
    property Alt: WideString read Get_Alt write Set_Alt;
  end;

{ IXMLImageTypeList }

  IXMLImageTypeList = interface(IXMLNodeCollection)
    ['{CA554E58-2B77-47D2-BAA6-BDD088421EF9}']
    { Methods & Properties }
    function Add: IXMLImageType;
    function Insert(const Index: Integer): IXMLImageType;
    function Get_Item(Index: Integer): IXMLImageType;
    property Items[Index: Integer]: IXMLImageType read Get_Item; default;
  end;

{ IXMLSequenceType }

  IXMLSequenceType = interface(IXMLNodeCollection)
    ['{47697462-2CA2-49C0-ACA1-C25D4AAF202E}']
    { Property Accessors }
    function Get_Name: WideString;
    function Get_Number: Integer;
    function Get_xmlLang: WideString;
    function Get_Sequence(Index: Integer): IXMLSequenceType;
    procedure Set_Name(Value: WideString);
    procedure Set_Number(Value: Integer);
    procedure Set_xmlLang(Value: WideString);
    { Methods & Properties }
    function Add: IXMLSequenceType;
    function Insert(const Index: Integer): IXMLSequenceType;
    property Name: WideString read Get_Name write Set_Name;
    property Number: Integer read Get_Number write Set_Number;
    property xmlLang: WideString read Get_xmlLang write Set_xmlLang;
    property Sequence[Index: Integer]: IXMLSequenceType read Get_Sequence; default;
  end;

{ IXMLSequenceTypeList }

  IXMLSequenceTypeList = interface(IXMLNodeCollection)
    ['{BA554E58-2B77-47D2-BAA6-BDD088421EF9}']
    { Methods & Properties }
    function Add: IXMLSequenceType;
    function Insert(const Index: Integer): IXMLSequenceType;
    function Get_Item(Index: Integer): IXMLSequenceType;
    property Items[Index: Integer]: IXMLSequenceType read Get_Item; default;
  end;

{ IXMLDocumentinfo }

  IXMLDocumentinfo = interface(IXMLNode)
    ['{3B01C85A-735E-4B8A-B556-BA6491BA87AB}']
    { Property Accessors }
    function Get_Author: IXMLAuthorTypeList;
    function Get_Programused: IXMLTextFieldType;
    function Get_Date: IXMLDateType;
    function Get_Srcurl: IXMLString_List;
    function Get_Srcocr: IXMLTextFieldType;
    function Get_Id: WideString;
    function Get_Version: String;
    function Get_History: IXMLAnnotationType;
    procedure Set_Id(Value: WideString);
    procedure Set_Version(Value: String);
    { Methods & Properties }
    property Author: IXMLAuthorTypeList read Get_Author;
    property Programused: IXMLTextFieldType read Get_Programused;
    property Date: IXMLDateType read Get_Date;
    property Srcurl: IXMLString_List read Get_Srcurl;
    property Srcocr: IXMLTextFieldType read Get_Srcocr;
    property Id: WideString read Get_Id write Set_Id;
    property Version: String read Get_Version write Set_Version;
    property History: IXMLAnnotationType read Get_History;
  end;

{ IXMLPublishinfo }

  IXMLPublishinfo = interface(IXMLNode)
    ['{44E47995-63D5-4814-9167-9CFF77032253}']
    { Property Accessors }
    function Get_Bookname: IXMLTextFieldType;
    function Get_Publisher: IXMLTextFieldType;
    function Get_City: IXMLTextFieldType;
    function Get_Year: WideString;
    function Get_Isbn: IXMLTextFieldType;
    function Get_Sequence: IXMLSequenceTypeList;
    procedure Set_Year(Value: WideString);
    { Methods & Properties }
    property Bookname: IXMLTextFieldType read Get_Bookname;
    property Publisher: IXMLTextFieldType read Get_Publisher;
    property City: IXMLTextFieldType read Get_City;
    property Year: WideString read Get_Year write Set_Year;
    property Isbn: IXMLTextFieldType read Get_Isbn;
    property Sequence: IXMLSequenceTypeList read Get_Sequence;
  end;

{ IXMLCustominfo }

  IXMLCustominfo = interface(IXMLNode)
    ['{D0DA51D9-525D-4B48-976E-9F6C56954384}']
    { Property Accessors }
    function Get_Infotype: WideString;
    procedure Set_Infotype(Value: WideString);
    { Methods & Properties }
    property Infotype: WideString read Get_Infotype write Set_Infotype;
  end;

{ IXMLCustominfoList }

  IXMLCustominfoList = interface(IXMLNodeCollection)
    ['{ABECCE6C-4DC0-4715-9008-1073ED3CE70B}']
    { Methods & Properties }
    function Add: IXMLCustominfo;
    function Insert(const Index: Integer): IXMLCustominfo;
    function Get_Item(Index: Integer): IXMLCustominfo;
    property Items[Index: Integer]: IXMLCustominfo read Get_Item; default;
  end;

{ IXMLShareInstructionType }

  IXMLShareInstructionType = interface(IXMLNode)
    ['{2AEC16AD-552A-4BED-B110-2E97E8422A58}']
    { Property Accessors }
    function Get_Mode: WideString;
    function Get_Includeall: WideString;
    function Get_Price: Single;
    function Get_Currency: WideString;
    function Get_Part: IXMLPartShareInstructionTypeList;
    function Get_Outputdocumentclass: IXMLOutPutDocumentTypeList;
    procedure Set_Mode(Value: WideString);
    procedure Set_Includeall(Value: WideString);
    procedure Set_Price(Value: Single);
    procedure Set_Currency(Value: WideString);
    { Methods & Properties }
    property Mode: WideString read Get_Mode write Set_Mode;
    property Includeall: WideString read Get_Includeall write Set_Includeall;
    property Price: Single read Get_Price write Set_Price;
    property Currency: WideString read Get_Currency write Set_Currency;
    property Part: IXMLPartShareInstructionTypeList read Get_Part;
    property Outputdocumentclass: IXMLOutPutDocumentTypeList read Get_Outputdocumentclass;
  end;

{ IXMLShareInstructionTypeList }

  IXMLShareInstructionTypeList = interface(IXMLNodeCollection)
    ['{2EE71021-3C27-4FCE-B65A-FF20EC21764E}']
    { Methods & Properties }
    function Add: IXMLShareInstructionType;
    function Insert(const Index: Integer): IXMLShareInstructionType;
    function Get_Item(Index: Integer): IXMLShareInstructionType;
    property Items[Index: Integer]: IXMLShareInstructionType read Get_Item; default;
  end;

{ IXMLPartShareInstructionType }

  IXMLPartShareInstructionType = interface(IXMLNode)
    ['{3DC5117F-BE9E-44B6-B972-B149539364BE}']
    { Property Accessors }
    function Get_xlinkType: WideString;
    function Get_xlinkHref: WideString;
    function Get_Include: WideString;
    procedure Set_xlinkType(Value: WideString);
    procedure Set_xlinkHref(Value: WideString);
    procedure Set_Include(Value: WideString);
    { Methods & Properties }
    property xlinkType: WideString read Get_xlinkType write Set_xlinkType;
    property xlinkHref: WideString read Get_xlinkHref write Set_xlinkHref;
    property Include: WideString read Get_Include write Set_Include;
  end;

{ IXMLPartShareInstructionTypeList }

  IXMLPartShareInstructionTypeList = interface(IXMLNodeCollection)
    ['{96D4C442-06AE-4067-85AF-F9A85F8928C7}']
    { Methods & Properties }
    function Add: IXMLPartShareInstructionType;
    function Insert(const Index: Integer): IXMLPartShareInstructionType;
    function Get_Item(Index: Integer): IXMLPartShareInstructionType;
    property Items[Index: Integer]: IXMLPartShareInstructionType read Get_Item; default;
  end;

{ IXMLOutPutDocumentType }

  IXMLOutPutDocumentType = interface(IXMLNodeCollection)
    ['{ABA7DD44-1B65-4982-8923-14CECEA1B432}']
    { Property Accessors }
    function Get_Name: WideString;
    function Get_Create: WideString;
    function Get_Price: Single;
    function Get_Part(Index: Integer): IXMLPartShareInstructionType;
    procedure Set_Name(Value: WideString);
    procedure Set_Create(Value: WideString);
    procedure Set_Price(Value: Single);
    { Methods & Properties }
    function Add: IXMLPartShareInstructionType;
    function Insert(const Index: Integer): IXMLPartShareInstructionType;
    property Name: WideString read Get_Name write Set_Name;
    property Create: WideString read Get_Create write Set_Create;
    property Price: Single read Get_Price write Set_Price;
    property Part[Index: Integer]: IXMLPartShareInstructionType read Get_Part; default;
  end;

{ IXMLOutPutDocumentTypeList }

  IXMLOutPutDocumentTypeList = interface(IXMLNodeCollection)
    ['{77D82091-F8F5-4205-9D6C-DEDA85FDD19D}']
    { Methods & Properties }
    function Add: IXMLOutPutDocumentType;
    function Insert(const Index: Integer): IXMLOutPutDocumentType;
    function Get_Item(Index: Integer): IXMLOutPutDocumentType;
    property Items[Index: Integer]: IXMLOutPutDocumentType read Get_Item; default;
  end;

{ IXMLBody }

  IXMLBody = interface(IXMLNode)
    ['{6E9E4B6E-AC8F-43EC-A0F2-066FE25AAC90}']
    { Property Accessors }
    function Get_Name: WideString;
    function Get_xmlLang: WideString;
    function Get_Image: IXMLImageType;
    function Get_Title: IXMLTitleType;
    function Get_Epigraph: IXMLEpigraphTypeList;
    function Get_Section: IXMLSectionTypeList;
    procedure Set_Name(Value: WideString);
    procedure Set_xmlLang(Value: WideString);
    { Methods & Properties }
    property Name: WideString read Get_Name write Set_Name;
    property xmlLang: WideString read Get_xmlLang write Set_xmlLang;
    property Image: IXMLImageType read Get_Image;
    property Title: IXMLTitleType read Get_Title;
    property Epigraph: IXMLEpigraphTypeList read Get_Epigraph;
    property Section: IXMLSectionTypeList read Get_Section;
  end;

{ IXMLBodyList }

  IXMLBodyList = interface(IXMLNodeCollection)
    ['{DB35CA4C-56CC-48C6-8F93-7915B0BCA3DA}']
    { Methods & Properties }
    function Add: IXMLBody;
    function Insert(const Index: Integer): IXMLBody;
    function Get_Item(Index: Integer): IXMLBody;
    property Items[Index: Integer]: IXMLBody read Get_Item; default;
  end;

{ IXMLSectionType }

  IXMLSectionType = interface(IXMLNode)
    ['{47EA44EC-C404-4E1E-ADAF-00257017F073}']
    { Property Accessors }
    function Get_Id: WideString;
    function Get_xmlLang: WideString;
    function Get_Title: IXMLTitleType;
    function Get_Epigraph: IXMLEpigraphTypeList;
    function Get_Image: IXMLImageType;
    function Get_Annotation: IXMLAnnotationType;
    function Get_Section: IXMLSectionTypeList;
    function Get_P: IXMLPType;
    function Get_Poem: IXMLPoemType;
    function Get_Subtitle: IXMLPType;
    function Get_Cite: IXMLCiteType;
    function Get_Emptyline: WideString;
    function Get_Table: IXMLTableType;
    procedure Set_Id(Value: WideString);
    procedure Set_xmlLang(Value: WideString);
    procedure Set_Emptyline(Value: WideString);
    { Methods & Properties }
    property Id: WideString read Get_Id write Set_Id;
    property xmlLang: WideString read Get_xmlLang write Set_xmlLang;
    property Title: IXMLTitleType read Get_Title;
    property Epigraph: IXMLEpigraphTypeList read Get_Epigraph;
    property Image: IXMLImageType read Get_Image;
    property Annotation: IXMLAnnotationType read Get_Annotation;
    property Section: IXMLSectionTypeList read Get_Section;
    property P: IXMLPType read Get_P;
    property Poem: IXMLPoemType read Get_Poem;
    property Subtitle: IXMLPType read Get_Subtitle;
    property Cite: IXMLCiteType read Get_Cite;
    property Emptyline: WideString read Get_Emptyline write Set_Emptyline;
    property Table: IXMLTableType read Get_Table;
  end;

{ IXMLSectionTypeList }

  IXMLSectionTypeList = interface(IXMLNodeCollection)
    ['{BF96891E-F998-4F72-9DE5-65BB3581F2F0}']
    { Methods & Properties }
    function Add: IXMLSectionType;
    function Insert(const Index: Integer): IXMLSectionType;
    function Get_Item(Index: Integer): IXMLSectionType;
    property Items[Index: Integer]: IXMLSectionType read Get_Item; default;
  end;

{ IXMLBinary }

  IXMLBinary = interface(IXMLNode)
    ['{891F9B68-FC99-47B1-99E7-F3F9CFDE9A41}']
    { Property Accessors }
    function Get_Contenttype: WideString;
    function Get_Id: WideString;
    procedure Set_Contenttype(Value: WideString);
    procedure Set_Id(Value: WideString);
    { Methods & Properties }
    property Contenttype: WideString read Get_Contenttype write Set_Contenttype;
    property Id: WideString read Get_Id write Set_Id;
  end;

{ IXMLBinaryList }

  IXMLBinaryList = interface(IXMLNodeCollection)
    ['{4E672A39-F4A5-4FAC-8322-0E00D2519883}']
    { Methods & Properties }
    function Add: IXMLBinary;
    function Insert(const Index: Integer): IXMLBinary;
    function Get_Item(Index: Integer): IXMLBinary;
    property Items[Index: Integer]: IXMLBinary read Get_Item; default;
  end;

{ IXMLPType }

  IXMLPType = interface(IXMLNode)
    ['{B4AD6A5A-760F-4FBF-8A3E-85B9B970A6D1}']
    { Property Accessors }
    function Get_Id: WideString;
    function Get_Style: WideString;
    function Get_Styles: IXMLStyleType;
    function Get_OnlyText: WideString;
    procedure Set_Id(Value: WideString);
    procedure Set_Style(Value: WideString);
    { Methods & Properties }
    property Id: WideString read Get_Id write Set_Id;
    property Style: WideString read Get_Style write Set_Style;
    property Styles: IXMLStyleType read Get_Styles;
    property OnlyText: WideString read Get_OnlyText;
  end;

{ IXMLPTypeList }

  IXMLPTypeList = interface(IXMLNodeCollection)
    ['{31B9BD17-40FF-4256-80C4-A3C0E678E242}']
    { Methods & Properties }
    function Add: IXMLPType;
    function Insert(const Index: Integer): IXMLPType;
    function Get_Item(Index: Integer): IXMLPType;
    property Items[Index: Integer]: IXMLPType read Get_Item; default;
  end;

{ IXMLNamedStyleType }

  IXMLNamedStyleType = interface(IXMLNode)
    ['{0963DFAB-E66B-4DFF-A958-84D257BAD81C}']
    { Property Accessors }
    function Get_xmlLang: WideString;
    function Get_Name: WideString;
    function Get_Strong: IXMLStyleType;
    function Get_Emphasis: IXMLStyleType;
    function Get_Style: IXMLNamedStyleType;
    function Get_A: IXMLLinkType;
    function Get_Strikethrough: IXMLStyleType;
    function Get_Sub: IXMLStyleType;
    function Get_Sup: IXMLStyleType;
    function Get_Code: IXMLStyleType;
    function Get_Image: IXMLImageType;
    procedure Set_xmlLang(Value: WideString);
    procedure Set_Name(Value: WideString);
    { Methods & Properties }
    property xmlLang: WideString read Get_xmlLang write Set_xmlLang;
    property Name: WideString read Get_Name write Set_Name;
    property Strong: IXMLStyleType read Get_Strong;
    property Emphasis: IXMLStyleType read Get_Emphasis;
    property Style: IXMLNamedStyleType read Get_Style;
    property A: IXMLLinkType read Get_A;
    property Strikethrough: IXMLStyleType read Get_Strikethrough;
    property Sub: IXMLStyleType read Get_Sub;
    property Sup: IXMLStyleType read Get_Sup;
    property Code: IXMLStyleType read Get_Code;
    property Image: IXMLImageType read Get_Image;
  end;

{ IXMLLinkType }

  IXMLLinkType = interface(IXMLNode)
    ['{69181AA5-395D-4EBA-86BF-801BB57E9B8C}']
    { Property Accessors }
    function Get_xlinkType: WideString;
    function Get_xlinkHref: WideString;
    function Get_attrType: WideString;
    function Get_Strong: IXMLStyleLinkType;
    function Get_Emphasis: IXMLStyleLinkType;
    function Get_Style: IXMLStyleLinkType;
    function Get_Strikethrough: IXMLStyleType;
    function Get_Sub: IXMLStyleType;
    function Get_Sup: IXMLStyleType;
    function Get_Code: IXMLStyleType;
    function Get_Image: IXMLImageType;
    procedure Set_xlinkType(Value: WideString);
    procedure Set_xlinkHref(Value: WideString);
    procedure Set_attrType(Value: WideString);
    { Methods & Properties }
    property xlinkType: WideString read Get_xlinkType write Set_xlinkType;
    property xlinkHref: WideString read Get_xlinkHref write Set_xlinkHref;
    property attrType: WideString read Get_attrType write Set_attrType;
    property Strong: IXMLStyleLinkType read Get_Strong;
    property Emphasis: IXMLStyleLinkType read Get_Emphasis;
    property Style: IXMLStyleLinkType read Get_Style;
    property Strikethrough: IXMLStyleType read Get_Strikethrough;
    property Sub: IXMLStyleType read Get_Sub;
    property Sup: IXMLStyleType read Get_Sup;
    property Code: IXMLStyleType read Get_Code;
    property Image: IXMLImageType read Get_Image;
  end;

{ IXMLStyleLinkType }

  IXMLStyleLinkType = interface(IXMLNode)
    ['{BEED24BC-B990-4B43-8AE2-34DBF091C906}']
    { Property Accessors }
    function Get_Strong: IXMLStyleLinkType;
    function Get_Emphasis: IXMLStyleLinkType;
    function Get_Style: IXMLStyleLinkType;
    { Methods & Properties }
    property Strong: IXMLStyleLinkType read Get_Strong;
    property Emphasis: IXMLStyleLinkType read Get_Emphasis;
    property Style: IXMLStyleLinkType read Get_Style;
  end;

{ IXMLGenreTypeList }

  IXMLGenreTypeList = interface(IXMLNodeCollection)
    ['{5DFE1BED-1C35-4754-AD72-E5F56B3C3473}']
    { Methods & Properties }
    function Add(const Value: WideString): IXMLNode;
    function Insert(const Index: Integer; const Value: WideString): IXMLNode;
    function Get_Item(Index: Integer): WideString;
    property Items[Index: Integer]: WideString read Get_Item; default;
  end;

{ IXMLString_List }

  IXMLString_List = interface(IXMLNodeCollection)
    ['{D8017B80-7CAE-4CFD-B38A-7143AB930B96}']
    { Methods & Properties }
    function Add(const Value: WideString): IXMLNode;
    function Insert(const Index: Integer; const Value: WideString): IXMLNode;
    function Get_Item(Index: Integer): WideString;
    property Items[Index: Integer]: WideString read Get_Item; default;
  end;

{ Forward Decls }

  TXMLFictionBook = class;
  TXMLStylesheet = class;
  TXMLStylesheetList = class;
  TXMLDescription = class;
  TXMLTitleinfoType = class;
  TXMLAuthorType = class;
  TXMLAuthorTypeList = class;
  TXMLTextFieldType = class;
  TXMLAnnotationType = class;
  TXMLStyleType = class;
  TXMLPoemType = class;
  TXMLTitleType = class;
  TXMLEpigraphType = class;
  TXMLEpigraphTypeList = class;
  TXMLCiteType = class;
  TXMLTableType = class;
  TXMLTr = class;
  TXMLStanza = class;
  TXMLStanzaList = class;
  TXMLDateType = class;
  TXMLCoverpage = class;
  TXMLImageType = class;
  TXMLImageTypeList = class;
  TXMLSequenceType = class;
  TXMLSequenceTypeList = class;
  TXMLDocumentinfo = class;
  TXMLPublishinfo = class;
  TXMLCustominfo = class;
  TXMLCustominfoList = class;
  TXMLShareInstructionType = class;
  TXMLShareInstructionTypeList = class;
  TXMLPartShareInstructionType = class;
  TXMLPartShareInstructionTypeList = class;
  TXMLOutPutDocumentType = class;
  TXMLOutPutDocumentTypeList = class;
  TXMLBody = class;
  TXMLBodyList = class;
  TXMLSectionType = class;
  TXMLSectionTypeList = class;
  TXMLBinary = class;
  TXMLBinaryList = class;
  TXMLPType = class;
  TXMLPTypeList = class;
  TXMLNamedStyleType = class;
  TXMLLinkType = class;
  TXMLStyleLinkType = class;
  TXMLGenreTypeList = class;
  TXMLString_List = class;

{ TXMLFictionBook }

  TXMLFictionBook = class(TXMLNode, IXMLFictionBook)
  private
    FStylesheet: IXMLStylesheetList;
    FBody: IXMLBodyList;
    FBinary: IXMLBinaryList;
  protected
    { IXMLFictionBook }
    function Get_Stylesheet: IXMLStylesheetList;
    function Get_Description: IXMLDescription;
    function Get_Body: IXMLBodyList;
    function Get_Binary: IXMLBinaryList;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLStylesheet }

  TXMLStylesheet = class(TXMLNode, IXMLStylesheet)
  protected
    { IXMLStylesheet }
    function Get_Type_: WideString;
    procedure Set_Type_(Value: WideString);
  end;

{ TXMLStylesheetList }

  TXMLStylesheetList = class(TXMLNodeCollection, IXMLStylesheetList)
  protected
    { IXMLStylesheetList }
    function Add: IXMLStylesheet;
    function Insert(const Index: Integer): IXMLStylesheet;
    function Get_Item(Index: Integer): IXMLStylesheet;
  end;

{ TXMLDescription }

  TXMLDescription = class(TXMLNode, IXMLDescription)
  private
    FCustominfo: IXMLCustominfoList;
    FOutput: IXMLShareInstructionTypeList;
  protected
    { IXMLDescription }
    function Get_Titleinfo: IXMLTitleinfoType;
    function Get_Srctitleinfo: IXMLTitleinfoType;
    function Get_Documentinfo: IXMLDocumentinfo;
    function Get_Publishinfo: IXMLPublishinfo;
    function Get_Custominfo: IXMLCustominfoList;
    function Get_Output: IXMLShareInstructionTypeList;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLTitleinfoType }

  TXMLTitleinfoType = class(TXMLNode, IXMLTitleinfoType)
  private
    FGenre: IXMLGenreTypeList;
    FAuthor: IXMLAuthorTypeList;
    FTranslator: IXMLAuthorTypeList;
    FSequence: IXMLSequenceTypeList;
  protected
    { IXMLTitleinfoType }
    function Get_Genre: IXMLGenreTypeList;
    function Get_Author: IXMLAuthorTypeList;
    function Get_Booktitle: IXMLTextFieldType;
    function Get_Annotation: IXMLAnnotationType;
    function Get_Keywords: IXMLTextFieldType;
    function Get_Date: IXMLDateType;
    function Get_Coverpage: IXMLCoverpage;
    function Get_Lang: WideString;
    function Get_Srclang: WideString;
    function Get_Translator: IXMLAuthorTypeList;
    function Get_Sequence: IXMLSequenceTypeList;
    procedure Set_Lang(Value: WideString);
    procedure Set_Srclang(Value: WideString);

  public
    procedure AfterConstruction; override;
  end;

{ TXMLAuthorType }

  TXMLAuthorType = class(TXMLNode, IXMLAuthorType)
  private
    FHomepage: IXMLString_List;
    FEmail: IXMLString_List;
  protected
    { IXMLAuthorType }
    function Get_Firstname: IXMLTextFieldType;
    function Get_Middlename: IXMLTextFieldType;
    function Get_Lastname: IXMLTextFieldType;
    function Get_Nickname: IXMLTextFieldType;
    function Get_Homepage: IXMLString_List;
    function Get_Email: IXMLString_List;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLAuthorTypeList }

  TXMLAuthorTypeList = class(TXMLNodeCollection, IXMLAuthorTypeList)
  protected
    { IXMLAuthorTypeList }
    function Add: IXMLAuthorType;
    function Insert(const Index: Integer): IXMLAuthorType;
    function Get_Item(Index: Integer): IXMLAuthorType;
  end;

{ TXMLTextFieldType }

  TXMLTextFieldType = class(TXMLNode, IXMLTextFieldType)
  protected
    { IXMLTextFieldType }
    function Get_xmlLang: WideString;
    procedure Set_xmlLang(Value: WideString);
  end;

{ TXMLAnnotationType }

  TXMLAnnotationType = class(TXMLNode, IXMLAnnotationType)
  private
    FP: IXMLPTypeList;
  protected
    { IXMLAnnotationType }
    function Get_Id: WideString;
    function Get_xmlLang: WideString;
    function Get_P: IXMLPTypeList;
    function Get_Poem: IXMLPoemType;
    function Get_Cite: IXMLCiteType;
    function Get_Subtitle: IXMLPType;
    function Get_Table: IXMLTableType;
    function Get_Emptyline: WideString;
    procedure Set_Id(Value: WideString);
    procedure Set_xmlLang(Value: WideString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLStyleType }

  TXMLStyleType = class(TXMLNode, IXMLStyleType)
  protected
    { IXMLStyleType }
    function Get_xmlLang: WideString;
    function Get_Strong: IXMLStyleType;
    function Get_Emphasis: IXMLStyleType;
    function Get_Style: IXMLNamedStyleType;
    function Get_A: IXMLLinkType;
    function Get_Strikethrough: IXMLStyleType;
    function Get_Sub: IXMLStyleType;
    function Get_Sup: IXMLStyleType;
    function Get_Code: IXMLStyleType;
    function Get_Image: IXMLImageType;
    procedure Set_xmlLang(Value: WideString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLPoemType }

  TXMLPoemType = class(TXMLNode, IXMLPoemType)
  private
    FEpigraph: IXMLEpigraphTypeList;
    FStanza: IXMLStanzaList;
    FTextauthor: IXMLPTypeList;
  protected
    { IXMLPoemType }
    function Get_Id: WideString;
    function Get_xmlLang: WideString;
    function Get_Title: IXMLTitleType;
    function Get_Epigraph: IXMLEpigraphTypeList;
    function Get_Stanza: IXMLStanzaList;
    function Get_Textauthor: IXMLPTypeList;
    function Get_Date: IXMLDateType;
    procedure Set_Id(Value: WideString);
    procedure Set_xmlLang(Value: WideString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLTitleType }

  TXMLTitleType = class(TXMLNode, IXMLTitleType)
  protected
    { IXMLTitleType }
    function Get_xmlLang: WideString;
    function Get_P: IXMLPType;
    function Get_Emptyline: WideString;
    procedure Set_xmlLang(Value: WideString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLEpigraphType }

  TXMLEpigraphType = class(TXMLNode, IXMLEpigraphType)
  private
    FTextauthor: IXMLPTypeList;
  protected
    { IXMLEpigraphType }
    function Get_Id: WideString;
    function Get_P: IXMLPType;
    function Get_Poem: IXMLPoemType;
    function Get_Cite: IXMLCiteType;
    function Get_Emptyline: WideString;
    function Get_Textauthor: IXMLPTypeList;
    procedure Set_Id(Value: WideString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLEpigraphTypeList }

  TXMLEpigraphTypeList = class(TXMLNodeCollection, IXMLEpigraphTypeList)
  protected
    { IXMLEpigraphTypeList }
    function Add: IXMLEpigraphType;
    function Insert(const Index: Integer): IXMLEpigraphType;
    function Get_Item(Index: Integer): IXMLEpigraphType;
  end;

{ TXMLCiteType }

  TXMLCiteType = class(TXMLNode, IXMLCiteType)
  private
    FTextauthor: IXMLPTypeList;
  protected
    { IXMLCiteType }
    function Get_Id: WideString;
    function Get_xmlLang: WideString;
    function Get_P: IXMLPType;
    function Get_Poem: IXMLPoemType;
    function Get_Emptyline: WideString;
    function Get_Subtitle: IXMLPType;
    function Get_Table: IXMLTableType;
    function Get_Textauthor: IXMLPTypeList;
    procedure Set_Id(Value: WideString);
    procedure Set_xmlLang(Value: WideString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLTableType }

  TXMLTableType = class(TXMLNodeCollection, IXMLTableType)
  protected
    { IXMLTableType }
    function Get_Tr(Index: Integer): IXMLTr;
    function Add: IXMLTr;
    function Insert(const Index: Integer): IXMLTr;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLTr }

  TXMLTr = class(TXMLNodeCollection, IXMLTr)
  protected
    { IXMLTr }
    function Get_Align: WideString;
    function Get_Td(Index: Integer): IXMLPTypeList;
    procedure Set_Align(Value: WideString);
    function Add: IXMLPType;
    function Insert(const Index: Integer): IXMLPType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLStanza }

  TXMLStanza = class(TXMLNode, IXMLStanza)
  private
    FV: IXMLPTypeList;
  protected
    { IXMLStanza }
    function Get_xmlLang: WideString;
    function Get_Title: IXMLTitleType;
    function Get_Subtitle: IXMLPType;
    function Get_V: IXMLPTypeList;
    procedure Set_xmlLang(Value: WideString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLStanzaList }

  TXMLStanzaList = class(TXMLNodeCollection, IXMLStanzaList)
  protected
    { IXMLStanzaList }
    function Add: IXMLStanza;
    function Insert(const Index: Integer): IXMLStanza;
    function Get_Item(Index: Integer): IXMLStanza;
  end;

{ TXMLDateType }

  TXMLDateType = class(TXMLNode, IXMLDateType)
  protected
    { IXMLDateType }
    function Get_Value: WideString;
    function Get_xmlLang: WideString;
    procedure Set_Value(Value: WideString);
    procedure Set_xmlLang(Value: WideString);
  end;

{ TXMLCoverpage }

  TXMLCoverpage = class(TXMLNodeCollection, IXMLCoverpage)
  protected
    { IXMLCoverpage }
    function Get_ImageList(Index: Integer): IXMLImageType;
    function Add: IXMLImageType;
    function Insert(const Index: Integer): IXMLImageType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLImageType }

  TXMLImageType = class(TXMLNode, IXMLImageType)
  protected
    { IXMLImageType }
    function Get_xlinkType: WideString;
    function Get_xlinkHref: WideString;
    function Get_Alt: WideString;
    procedure Set_xlinkType(Value: WideString);
    procedure Set_xlinkHref(Value: WideString);
    procedure Set_Alt(Value: WideString);
  end;

{ TXMLImageTypeList }

  TXMLImageTypeList = class(TXMLNodeCollection, IXMLImageTypeList)
  protected
    { IXMLSequenceTypeList }
    function Add: IXMLImageType;
    function Insert(const Index: Integer): IXMLImageType;
    function Get_Item(Index: Integer): IXMLImageType;
  end;

{ TXMLSequenceType }

  TXMLSequenceType = class(TXMLNodeCollection, IXMLSequenceType)
  protected
    { IXMLSequenceType }
    function Get_Name: WideString;
    function Get_Number: Integer;
    function Get_xmlLang: WideString;
    function Get_Sequence(Index: Integer): IXMLSequenceType;
    procedure Set_Name(Value: WideString);
    procedure Set_Number(Value: Integer);
    procedure Set_xmlLang(Value: WideString);
    function Add: IXMLSequenceType;
    function Insert(const Index: Integer): IXMLSequenceType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLSequenceTypeList }

  TXMLSequenceTypeList = class(TXMLNodeCollection, IXMLSequenceTypeList)
  protected
    { IXMLSequenceTypeList }
    function Add: IXMLSequenceType;
    function Insert(const Index: Integer): IXMLSequenceType;
    function Get_Item(Index: Integer): IXMLSequenceType;
  end;

{ TXMLDocumentinfo }

  TXMLDocumentinfo = class(TXMLNode, IXMLDocumentinfo)
  private
    FAuthor: IXMLAuthorTypeList;
    FSrcurl: IXMLString_List;
  protected
    { IXMLDocumentinfo }
    function Get_Author: IXMLAuthorTypeList;
    function Get_Programused: IXMLTextFieldType;
    function Get_Date: IXMLDateType;
    function Get_Srcurl: IXMLString_List;
    function Get_Srcocr: IXMLTextFieldType;
    function Get_Id: WideString;
    function Get_Version: String;
    function Get_History: IXMLAnnotationType;
    procedure Set_Id(Value: WideString);
    procedure Set_Version(Value: string);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLPublishinfo }

  TXMLPublishinfo = class(TXMLNode, IXMLPublishinfo)
  private
    FSequence: IXMLSequenceTypeList;
  protected
    { IXMLPublishinfo }
    function Get_Bookname: IXMLTextFieldType;
    function Get_Publisher: IXMLTextFieldType;
    function Get_City: IXMLTextFieldType;
    function Get_Year: WideString;
    function Get_Isbn: IXMLTextFieldType;
    function Get_Sequence: IXMLSequenceTypeList;
    procedure Set_Year(Value: WideString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLCustominfo }

  TXMLCustominfo = class(TXMLNode, IXMLCustominfo)
  protected
    { IXMLCustominfo }
    function Get_Infotype: WideString;
    procedure Set_Infotype(Value: WideString);
  end;

{ TXMLCustominfoList }

  TXMLCustominfoList = class(TXMLNodeCollection, IXMLCustominfoList)
  protected
    { IXMLCustominfoList }
    function Add: IXMLCustominfo;
    function Insert(const Index: Integer): IXMLCustominfo;
    function Get_Item(Index: Integer): IXMLCustominfo;
  end;

{ TXMLShareInstructionType }

  TXMLShareInstructionType = class(TXMLNode, IXMLShareInstructionType)
  private
    FPart: IXMLPartShareInstructionTypeList;
    FOutputdocumentclass: IXMLOutPutDocumentTypeList;
  protected
    { IXMLShareInstructionType }
    function Get_Mode: WideString;
    function Get_Includeall: WideString;
    function Get_Price: Single;
    function Get_Currency: WideString;
    function Get_Part: IXMLPartShareInstructionTypeList;
    function Get_Outputdocumentclass: IXMLOutPutDocumentTypeList;
    procedure Set_Mode(Value: WideString);
    procedure Set_Includeall(Value: WideString);
    procedure Set_Price(Value: Single);
    procedure Set_Currency(Value: WideString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLShareInstructionTypeList }

  TXMLShareInstructionTypeList = class(TXMLNodeCollection, IXMLShareInstructionTypeList)
  protected
    { IXMLShareInstructionTypeList }
    function Add: IXMLShareInstructionType;
    function Insert(const Index: Integer): IXMLShareInstructionType;
    function Get_Item(Index: Integer): IXMLShareInstructionType;
  end;

{ TXMLPartShareInstructionType }

  TXMLPartShareInstructionType = class(TXMLNode, IXMLPartShareInstructionType)
  protected
    { IXMLPartShareInstructionType }
    function Get_xlinkType: WideString;
    function Get_xlinkHref: WideString;
    function Get_Include: WideString;
    procedure Set_xlinkType(Value: WideString);
    procedure Set_xlinkHref(Value: WideString);
    procedure Set_Include(Value: WideString);
  end;

{ TXMLPartShareInstructionTypeList }

  TXMLPartShareInstructionTypeList = class(TXMLNodeCollection, IXMLPartShareInstructionTypeList)
  protected
    { IXMLPartShareInstructionTypeList }
    function Add: IXMLPartShareInstructionType;
    function Insert(const Index: Integer): IXMLPartShareInstructionType;
    function Get_Item(Index: Integer): IXMLPartShareInstructionType;
  end;

{ TXMLOutPutDocumentType }

  TXMLOutPutDocumentType = class(TXMLNodeCollection, IXMLOutPutDocumentType)
  protected
    { IXMLOutPutDocumentType }
    function Get_Name: WideString;
    function Get_Create: WideString;
    function Get_Price: Single;
    function Get_Part(Index: Integer): IXMLPartShareInstructionType;
    procedure Set_Name(Value: WideString);
    procedure Set_Create(Value: WideString);
    procedure Set_Price(Value: Single);
    function Add: IXMLPartShareInstructionType;
    function Insert(const Index: Integer): IXMLPartShareInstructionType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLOutPutDocumentTypeList }

  TXMLOutPutDocumentTypeList = class(TXMLNodeCollection, IXMLOutPutDocumentTypeList)
  protected
    { IXMLOutPutDocumentTypeList }
    function Add: IXMLOutPutDocumentType;
    function Insert(const Index: Integer): IXMLOutPutDocumentType;
    function Get_Item(Index: Integer): IXMLOutPutDocumentType;
  end;

{ TXMLBody }

  TXMLBody = class(TXMLNode, IXMLBody)
  private
    FEpigraph: IXMLEpigraphTypeList;
    FSection: IXMLSectionTypeList;
  protected
    { IXMLBody }
    function Get_Name: WideString;
    function Get_xmlLang: WideString;
    function Get_Image: IXMLImageType;
    function Get_Title: IXMLTitleType;
    function Get_Epigraph: IXMLEpigraphTypeList;
    function Get_Section: IXMLSectionTypeList;
    procedure Set_Name(Value: WideString);
    procedure Set_xmlLang(Value: WideString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLBodyList }

  TXMLBodyList = class(TXMLNodeCollection, IXMLBodyList)
  protected
    { IXMLBodyList }
    function Add: IXMLBody;
    function Insert(const Index: Integer): IXMLBody;
    function Get_Item(Index: Integer): IXMLBody;
  end;

{ TXMLSectionType }

  TXMLSectionType = class(TXMLNode, IXMLSectionType)
  private
    FEpigraph: IXMLEpigraphTypeList;
    FSection: IXMLSectionTypeList;
  protected
    { IXMLSectionType }
    function Get_Id: WideString;
    function Get_xmlLang: WideString;
    function Get_Title: IXMLTitleType;
    function Get_Epigraph: IXMLEpigraphTypeList;
    function Get_Image: IXMLImageType;
    function Get_Annotation: IXMLAnnotationType;
    function Get_Section: IXMLSectionTypeList;
    function Get_P: IXMLPType;
    function Get_Poem: IXMLPoemType;
    function Get_Subtitle: IXMLPType;
    function Get_Cite: IXMLCiteType;
    function Get_Emptyline: WideString;
    function Get_Table: IXMLTableType;
    procedure Set_Id(Value: WideString);
    procedure Set_xmlLang(Value: WideString);
    procedure Set_Emptyline(Value: WideString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLSectionTypeList }

  TXMLSectionTypeList = class(TXMLNodeCollection, IXMLSectionTypeList)
  protected
    { IXMLSectionTypeList }
    function Add: IXMLSectionType;
    function Insert(const Index: Integer): IXMLSectionType;
    function Get_Item(Index: Integer): IXMLSectionType;
  end;

{ TXMLBinary }

  TXMLBinary = class(TXMLNode, IXMLBinary)
  protected
    { IXMLBinary }
    function Get_Contenttype: WideString;
    function Get_Id: WideString;
    procedure Set_Contenttype(Value: WideString);
    procedure Set_Id(Value: WideString);
  end;

{ TXMLBinaryList }

  TXMLBinaryList = class(TXMLNodeCollection, IXMLBinaryList)
  protected
    { IXMLBinaryList }
    function Add: IXMLBinary;
    function Insert(const Index: Integer): IXMLBinary;
    function Get_Item(Index: Integer): IXMLBinary;
  end;

{ TXMLPType }

  TXMLPType = class(TXMLStyleType, IXMLPType)
  protected
    { IXMLPType }
    function Get_Id: WideString;
    function Get_Style: WideString;
    function Get_Styles: IXMLStyleType;
    function Get_OnlyText: WideString;
    procedure Set_Id(Value: WideString);
    procedure Set_Style(Value: WideString);
  end;

{ TXMLPTypeList }

  TXMLPTypeList = class(TXMLNodeCollection, IXMLPTypeList)
  protected
    { IXMLPTypeList }
    function Add: IXMLPType;
    function Insert(const Index: Integer): IXMLPType;
    function Get_Item(Index: Integer): IXMLPType;
  end;

{ TXMLNamedStyleType }

   TXMLNamedStyleType = class(TXMLNode, IXMLNamedStyleType)
  protected
    { IXMLNamedStyleType }
    function Get_xmlLang: WideString;
    function Get_Name: WideString;
    function Get_Strong: IXMLStyleType;
    function Get_Emphasis: IXMLStyleType;
    function Get_Style: IXMLNamedStyleType;
    function Get_A: IXMLLinkType;
    function Get_Strikethrough: IXMLStyleType;
    function Get_Sub: IXMLStyleType;
    function Get_Sup: IXMLStyleType;
    function Get_Code: IXMLStyleType;
    function Get_Image: IXMLImageType;
    procedure Set_xmlLang(Value: WideString);
    procedure Set_Name(Value: WideString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLLinkType }

  TXMLLinkType = class(TXMLNode, IXMLLinkType)
  protected
    { IXMLLinkType }
    function Get_xlinkType: WideString;
    function Get_xlinkHref: WideString;
    function Get_attrType: WideString;
    function Get_Strong: IXMLStyleLinkType;
    function Get_Emphasis: IXMLStyleLinkType;
    function Get_Style: IXMLStyleLinkType;
    function Get_Strikethrough: IXMLStyleType;
    function Get_Sub: IXMLStyleType;
    function Get_Sup: IXMLStyleType;
    function Get_Code: IXMLStyleType;
    function Get_Image: IXMLImageType;
    procedure Set_xlinkType(Value: WideString);
    procedure Set_xlinkHref(Value: WideString);
    procedure Set_attrType(Value: WideString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLStyleLinkType }

  TXMLStyleLinkType = class(TXMLNode, IXMLStyleLinkType)
  protected
    { IXMLStyleLinkType }
    function Get_Strong: IXMLStyleLinkType;
    function Get_Emphasis: IXMLStyleLinkType;
    function Get_Style: IXMLStyleLinkType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLGenreTypeList }

  TXMLGenreTypeList = class(TXMLNodeCollection, IXMLGenreTypeList)
  protected
    { IXMLGenreTypeList }
    function Add(const Value: WideString): IXMLNode;
    function Insert(const Index: Integer; const Value: WideString): IXMLNode;
    function Get_Item(Index: Integer): WideString;
  end;

{ TXMLString_List }

  TXMLString_List = class(TXMLNodeCollection, IXMLString_List)
  protected
    { IXMLString_List }
    function Add(const Value: WideString): IXMLNode;
    function Insert(const Index: Integer; const Value: WideString): IXMLNode;
    function Get_Item(Index: Integer): WideString;
  end;

{ Global Functions }

function GetFictionBook(Doc: IXMLDocument): IXMLFictionBook;
function NewFictionBook: IXMLFictionBook;
function LoadFictionBook(const FileName: WideString): IXMLFictionBook; overload;
function LoadFictionBook(const Stream: TStream): IXMLFictionBook; overload;

const
  TargetNamespace = 'http://www.gribuser.ru/xml/fictionbook/2.0';

implementation

{ Global Functions }

function GetFictionBook(Doc: IXMLDocument): IXMLFictionBook;
begin
  Result := Doc.GetDocBinding('FictionBook', TXMLFictionBook, TargetNamespace) as IXMLFictionBook;
end;

function NewFictionBook: IXMLFictionBook;
begin
  Result := NewXMLDocument.GetDocBinding('FictionBook', TXMLFictionBook, TargetNamespace) as IXMLFictionBook;
end;

function LoadFictionBook(const FileName: WideString): IXMLFictionBook; overload;
begin
  Result := LoadXMLDocument(FileName).GetDocBinding('FictionBook', TXMLFictionBook, TargetNamespace) as IXMLFictionBook;
end;

function LoadFictionBook(const Stream: TStream): IXMLFictionBook; overload;
var
  Doc: IXMLDocument;
begin
  Doc := TXMLDocument.Create(nil);
  Doc.LoadFromStream(Stream);
  Result := Doc.GetDocBinding('FictionBook', TXMLFictionBook, TargetNamespace) as IXMLFictionBook;
end;

{ TXMLFictionBook }

procedure TXMLFictionBook.AfterConstruction;
begin
  RegisterChildNode('stylesheet', TXMLStylesheet);
  RegisterChildNode('description', TXMLDescription);
  RegisterChildNode('body', TXMLBody);
  RegisterChildNode('binary', TXMLBinary);
  FStylesheet := CreateCollection(TXMLStylesheetList, IXMLStylesheet, 'stylesheet') as IXMLStylesheetList;
  FBody := CreateCollection(TXMLBodyList, IXMLBody, 'body') as IXMLBodyList;
  FBinary := CreateCollection(TXMLBinaryList, IXMLBinary, 'binary') as IXMLBinaryList;
  inherited;
end;

function TXMLFictionBook.Get_Stylesheet: IXMLStylesheetList;
begin
  Result := FStylesheet;
end;

function TXMLFictionBook.Get_Description: IXMLDescription;
begin
  Result := ChildNodes['description'] as IXMLDescription;
end;

function TXMLFictionBook.Get_Body: IXMLBodyList;
begin
  Result := FBody;
end;

function TXMLFictionBook.Get_Binary: IXMLBinaryList;
begin
  Result := FBinary;
end;

{ TXMLStylesheet }

function TXMLStylesheet.Get_Type_: WideString;
begin
  Result := AttributeNodes['type'].Text;
end;

procedure TXMLStylesheet.Set_Type_(Value: WideString);
begin
  SetAttribute('type', Value);
end;

{ TXMLStylesheetList }

function TXMLStylesheetList.Add: IXMLStylesheet;
begin
  Result := AddItem(-1) as IXMLStylesheet;
end;

function TXMLStylesheetList.Insert(const Index: Integer): IXMLStylesheet;
begin
  Result := AddItem(Index) as IXMLStylesheet;
end;
function TXMLStylesheetList.Get_Item(Index: Integer): IXMLStylesheet;
begin
  if List.Count > 0 then Result := List[Index] as IXMLStylesheet;
end;

{ TXMLDescription }

procedure TXMLDescription.AfterConstruction;
begin
  RegisterChildNode('title-info', TXMLTitleinfoType);
  RegisterChildNode('src-title-info', TXMLTitleinfoType);
  RegisterChildNode('document-info', TXMLDocumentinfo);
  RegisterChildNode('publish-info', TXMLPublishinfo);
  RegisterChildNode('custom-info', TXMLCustominfo);
  RegisterChildNode('output', TXMLShareInstructionType);
  FCustominfo := CreateCollection(TXMLCustominfoList, IXMLCustominfo, 'custom-info') as IXMLCustominfoList;
  FOutput := CreateCollection(TXMLShareInstructionTypeList, IXMLShareInstructionType, 'output') as IXMLShareInstructionTypeList;
  inherited;
end;

function TXMLDescription.Get_Titleinfo: IXMLTitleinfoType;
begin
  Result := ChildNodes['title-info'] as IXMLTitleinfoType;
end;

function TXMLDescription.Get_Srctitleinfo: IXMLTitleinfoType;
begin
  Result := ChildNodes['src-title-info'] as IXMLTitleinfoType;
end;

function TXMLDescription.Get_Documentinfo: IXMLDocumentinfo;
begin
  Result := ChildNodes['document-info'] as IXMLDocumentinfo;
end;

function TXMLDescription.Get_Publishinfo: IXMLPublishinfo;
begin
  Result := ChildNodes['publish-info'] as IXMLPublishinfo;
end;

function TXMLDescription.Get_Custominfo: IXMLCustominfoList;
begin
  Result := FCustominfo;
end;

function TXMLDescription.Get_Output: IXMLShareInstructionTypeList;
begin
  Result := FOutput;
end;

{ TXMLTitleinfoType }

procedure TXMLTitleinfoType.AfterConstruction;
begin
  RegisterChildNode('author', TXMLAuthorType);
  RegisterChildNode('book-title', TXMLTextFieldType);
  RegisterChildNode('annotation', TXMLAnnotationType);
  RegisterChildNode('keywords', TXMLTextFieldType);
  RegisterChildNode('date', TXMLDateType);
  RegisterChildNode('coverpage', TXMLCoverpage);
  RegisterChildNode('translator', TXMLAuthorType);
  RegisterChildNode('sequence', TXMLSequenceType);
  FGenre := CreateCollection(TXMLGenreTypeList, IXMLNode, 'genre') as IXMLGenreTypeList;
  FAuthor := CreateCollection(TXMLAuthorTypeList, IXMLAuthorType, 'author') as IXMLAuthorTypeList;
  FTranslator := CreateCollection(TXMLAuthorTypeList, IXMLAuthorType, 'translator') as IXMLAuthorTypeList;
  FSequence := CreateCollection(TXMLSequenceTypeList, IXMLSequenceType, 'sequence') as IXMLSequenceTypeList;
  inherited;
end;

function TXMLTitleinfoType.Get_Genre: IXMLGenreTypeList;
begin
  Result := FGenre;
end;

function TXMLTitleinfoType.Get_Author: IXMLAuthorTypeList;
begin
  Result := FAuthor;
end;

function TXMLTitleinfoType.Get_Booktitle: IXMLTextFieldType;
begin
  Result := ChildNodes['book-title'] as IXMLTextFieldType;
end;

function TXMLTitleinfoType.Get_Annotation: IXMLAnnotationType;
begin
  Result := ChildNodes['annotation'] as IXMLAnnotationType;
end;

function TXMLTitleinfoType.Get_Keywords: IXMLTextFieldType;
begin
  Result := ChildNodes['keywords'] as IXMLTextFieldType;
end;

function TXMLTitleinfoType.Get_Date: IXMLDateType;
begin
  Result := ChildNodes['date'] as IXMLDateType;
end;

function TXMLTitleinfoType.Get_Coverpage: IXMLCoverpage;
begin
  Result := ChildNodes['coverpage'] as IXMLCoverpage;
end;

function TXMLTitleinfoType.Get_Lang: WideString;
begin
  Result := ChildNodes['lang'].Text;
end;

procedure TXMLTitleinfoType.Set_Lang(Value: WideString);
begin
  ChildNodes['lang'].NodeValue := Value;
end;

function TXMLTitleinfoType.Get_Srclang: WideString;
begin
  Result := ChildNodes['src-lang'].Text;
end;

procedure TXMLTitleinfoType.Set_Srclang(Value: WideString);
begin
  ChildNodes['src-lang'].NodeValue := Value;
end;

function TXMLTitleinfoType.Get_Translator: IXMLAuthorTypeList;
begin
  Result := FTranslator;
end;

function TXMLTitleinfoType.Get_Sequence: IXMLSequenceTypeList;
begin
  Result := FSequence;
end;

{ TXMLAuthorType }

procedure TXMLAuthorType.AfterConstruction;
begin
  RegisterChildNode('first-name', TXMLTextFieldType);
  RegisterChildNode('middle-name', TXMLTextFieldType);
  RegisterChildNode('last-name', TXMLTextFieldType);
  RegisterChildNode('nickname', TXMLTextFieldType);
  FHomepage := CreateCollection(TXMLString_List, IXMLNode, 'home-page') as IXMLString_List;
  FEmail := CreateCollection(TXMLString_List, IXMLNode, 'email') as IXMLString_List;
  inherited;
end;

function TXMLAuthorType.Get_Firstname: IXMLTextFieldType;
begin
  Result := ChildNodes['first-name'] as IXMLTextFieldType;
end;

function TXMLAuthorType.Get_Middlename: IXMLTextFieldType;
begin
  Result := ChildNodes['middle-name'] as IXMLTextFieldType;
end;

function TXMLAuthorType.Get_Lastname: IXMLTextFieldType;
begin
  Result := ChildNodes['last-name'] as IXMLTextFieldType;
end;

function TXMLAuthorType.Get_Nickname: IXMLTextFieldType;
begin
  Result := ChildNodes['nickname'] as IXMLTextFieldType;
end;

function TXMLAuthorType.Get_Homepage: IXMLString_List;
begin
  Result := FHomepage;
end;

function TXMLAuthorType.Get_Email: IXMLString_List;
begin
  Result := FEmail;
end;

{ TXMLAuthorTypeList }

function TXMLAuthorTypeList.Add: IXMLAuthorType;
begin
  Result := AddItem(-1) as IXMLAuthorType;
end;

function TXMLAuthorTypeList.Insert(const Index: Integer): IXMLAuthorType;
begin
  Result := AddItem(Index) as IXMLAuthorType;
end;
function TXMLAuthorTypeList.Get_Item(Index: Integer): IXMLAuthorType;
begin
  if List.Count > 0 then Result := List[Index] as IXMLAuthorType;
end;

{ TXMLTextFieldType }

function TXMLTextFieldType.Get_xmlLang: WideString;
begin
  Result := AttributeNodes['xml:lang'].Text;
end;

procedure TXMLTextFieldType.Set_xmlLang(Value: WideString);
begin
  SetAttribute('xml:lang', Value);
end;

{ TXMLAnnotationType }

procedure TXMLAnnotationType.AfterConstruction;
begin
  RegisterChildNode('p', TXMLPType);
  RegisterChildNode('poem', TXMLPoemType);
  RegisterChildNode('cite', TXMLCiteType);
  RegisterChildNode('subtitle', TXMLPType);
  RegisterChildNode('table', TXMLTableType);
  FP := CreateCollection(TXMLPTypeList, IXMLPType, 'p') as IXMLPTypeList;
  inherited;
end;

function TXMLAnnotationType.Get_Id: WideString;
begin
  Result := AttributeNodes['id'].Text;
end;

procedure TXMLAnnotationType.Set_Id(Value: WideString);
begin
  SetAttribute('id', Value);
end;

function TXMLAnnotationType.Get_xmlLang: WideString;
begin
  Result := AttributeNodes['xml:lang'].Text;
end;

procedure TXMLAnnotationType.Set_xmlLang(Value: WideString);
begin
  SetAttribute('xml:lang', Value);
end;

function TXMLAnnotationType.Get_Poem: IXMLPoemType;
begin
  Result := ChildNodes['poem'] as IXMLPoemType;
end;

function TXMLAnnotationType.Get_P: IXMLPTypeList;
begin
  Result := FP;
end;

function TXMLAnnotationType.Get_Cite: IXMLCiteType;
begin
  Result := ChildNodes['cite'] as IXMLCiteType;
end;

function TXMLAnnotationType.Get_Subtitle: IXMLPType;
begin
  Result := ChildNodes['subtitle'] as IXMLPType;
end;

function TXMLAnnotationType.Get_Table: IXMLTableType;
begin
  Result := ChildNodes['table'] as IXMLTableType;
end;

function TXMLAnnotationType.Get_Emptyline: WideString;
begin
  Result := ChildNodes['empty-line'].Text;
end;

{ TXMLStyleType }

procedure TXMLStyleType.AfterConstruction;
begin
  RegisterChildNode('strong', TXMLStyleType);
  RegisterChildNode('emphasis', TXMLStyleType);
  RegisterChildNode('style', TXMLNamedStyleType);
  RegisterChildNode('a', TXMLLinkType);
  RegisterChildNode('strikethrough', TXMLStyleType);
  RegisterChildNode('sub', TXMLStyleType);
  RegisterChildNode('sup', TXMLStyleType);
  RegisterChildNode('code', TXMLStyleType);
  RegisterChildNode('image', TXMLImageType);
  inherited;
end;

function TXMLStyleType.Get_xmlLang: WideString;
begin
  Result := AttributeNodes['xml:lang'].Text;
end;

procedure TXMLStyleType.Set_xmlLang(Value: WideString);
begin
  SetAttribute('xml:lang', Value);
end;

function TXMLStyleType.Get_Strong: IXMLStyleType;
begin
  Result := ChildNodes['strong'] as IXMLStyleType;
end;

function TXMLStyleType.Get_Emphasis: IXMLStyleType;
begin
  Result := ChildNodes['emphasis'] as IXMLStyleType;
end;

function TXMLStyleType.Get_Style: IXMLNamedStyleType;
begin
  Result := ChildNodes['style'] as IXMLNamedStyleType;
end;

function TXMLStyleType.Get_A: IXMLLinkType;
begin
  Result := ChildNodes['a'] as IXMLLinkType;
end;

function TXMLStyleType.Get_Strikethrough: IXMLStyleType;
begin
  Result := ChildNodes['strikethrough'] as IXMLStyleType;
end;

function TXMLStyleType.Get_Sub: IXMLStyleType;
begin
  Result := ChildNodes['sub'] as IXMLStyleType;
end;

function TXMLStyleType.Get_Sup: IXMLStyleType;
begin
  Result := ChildNodes['sup'] as IXMLStyleType;
end;

function TXMLStyleType.Get_Code: IXMLStyleType;
begin
  Result := ChildNodes['code'] as IXMLStyleType;
end;

function TXMLStyleType.Get_Image: IXMLImageType;
begin
  Result := ChildNodes['image'] as IXMLImageType;
end;

{ TXMLPoemType }

procedure TXMLPoemType.AfterConstruction;
begin
  RegisterChildNode('title', TXMLTitleType);
  RegisterChildNode('epigraph', TXMLEpigraphType);
  RegisterChildNode('stanza', TXMLStanza);
  RegisterChildNode('date', TXMLDateType);
  FEpigraph := CreateCollection(TXMLEpigraphTypeList, IXMLEpigraphType, 'epigraph') as IXMLEpigraphTypeList;
  FStanza := CreateCollection(TXMLStanzaList, IXMLStanza, 'stanza') as IXMLStanzaList;
  FTextauthor := CreateCollection(TXMLPTypeList, IXMLPType, 'text-author') as IXMLPTypeList;
  inherited;
end;

function TXMLPoemType.Get_Id: WideString;
begin
  Result := AttributeNodes['id'].Text;
end;

procedure TXMLPoemType.Set_Id(Value: WideString);
begin
  SetAttribute('id', Value);
end;

function TXMLPoemType.Get_xmlLang: WideString;
begin
  Result := AttributeNodes['xml:lang'].Text;
end;

procedure TXMLPoemType.Set_xmlLang(Value: WideString);
begin
  SetAttribute('xml:lang', Value);
end;

function TXMLPoemType.Get_Title: IXMLTitleType;
begin
  Result := ChildNodes['title'] as IXMLTitleType;
end;

function TXMLPoemType.Get_Epigraph: IXMLEpigraphTypeList;
begin
  Result := FEpigraph;
end;

function TXMLPoemType.Get_Stanza: IXMLStanzaList;
begin
  Result := FStanza;
end;

function TXMLPoemType.Get_Textauthor: IXMLPTypeList;
begin
  Result := FTextauthor;
end;

function TXMLPoemType.Get_Date: IXMLDateType;
begin
  Result := ChildNodes['date'] as IXMLDateType;
end;

{ TXMLTitleType }

procedure TXMLTitleType.AfterConstruction;
begin
  RegisterChildNode('p', TXMLPType);
  inherited;
end;

function TXMLTitleType.Get_xmlLang: WideString;
begin
  Result := AttributeNodes['xml:lang'].Text;
end;

procedure TXMLTitleType.Set_xmlLang(Value: WideString);
begin
  SetAttribute('xml:lang', Value);
end;

function TXMLTitleType.Get_P: IXMLPType;
begin
  Result := ChildNodes['p'] as IXMLPType;
end;

function TXMLTitleType.Get_Emptyline: WideString;
begin
  Result := ChildNodes['empty-line'].Text;
end;

{ TXMLEpigraphType }

procedure TXMLEpigraphType.AfterConstruction;
begin
  RegisterChildNode('p', TXMLPType);
  RegisterChildNode('poem', TXMLPoemType);
  RegisterChildNode('cite', TXMLCiteType);
  FTextauthor := CreateCollection(TXMLPTypeList, IXMLPType, 'text-author') as IXMLPTypeList;
  inherited;
end;

function TXMLEpigraphType.Get_Id: WideString;
begin
  Result := AttributeNodes['id'].Text;
end;

procedure TXMLEpigraphType.Set_Id(Value: WideString);
begin
  SetAttribute('id', Value);
end;

function TXMLEpigraphType.Get_P: IXMLPType;
begin
  Result := ChildNodes['p'] as IXMLPType;
end;

function TXMLEpigraphType.Get_Poem: IXMLPoemType;
begin
  Result := ChildNodes['poem'] as IXMLPoemType;
end;

function TXMLEpigraphType.Get_Cite: IXMLCiteType;
begin
  Result := ChildNodes['cite'] as IXMLCiteType;
end;

function TXMLEpigraphType.Get_Emptyline: WideString;
begin
  Result := ChildNodes['empty-line'].Text;
end;

function TXMLEpigraphType.Get_Textauthor: IXMLPTypeList;
begin
  Result := FTextauthor;
end;

{ TXMLEpigraphTypeList }

function TXMLEpigraphTypeList.Add: IXMLEpigraphType;
begin
  Result := AddItem(-1) as IXMLEpigraphType;
end;

function TXMLEpigraphTypeList.Insert(const Index: Integer): IXMLEpigraphType;
begin
  Result := AddItem(Index) as IXMLEpigraphType;
end;
function TXMLEpigraphTypeList.Get_Item(Index: Integer): IXMLEpigraphType;
begin
  if List.Count > 0 then Result := List[Index] as IXMLEpigraphType;
end;

{ TXMLCiteType }

procedure TXMLCiteType.AfterConstruction;
begin
  RegisterChildNode('p', TXMLPType);
  RegisterChildNode('poem', TXMLPoemType);
  RegisterChildNode('subtitle', TXMLPType);
  RegisterChildNode('table', TXMLTableType);
  FTextauthor := CreateCollection(TXMLPTypeList, IXMLPType, 'text-author') as IXMLPTypeList;
  inherited;
end;

function TXMLCiteType.Get_Id: WideString;
begin
  Result := AttributeNodes['id'].Text;
end;

procedure TXMLCiteType.Set_Id(Value: WideString);
begin
  SetAttribute('id', Value);
end;

function TXMLCiteType.Get_xmlLang: WideString;
begin
  Result := AttributeNodes['xml:lang'].Text;
end;

procedure TXMLCiteType.Set_xmlLang(Value: WideString);
begin
  SetAttribute('xml:lang', Value);
end;

function TXMLCiteType.Get_P: IXMLPType;
begin
  Result := ChildNodes['p'] as IXMLPType;
end;

function TXMLCiteType.Get_Poem: IXMLPoemType;
begin
  Result := ChildNodes['poem'] as IXMLPoemType;
end;

function TXMLCiteType.Get_Emptyline: WideString;
begin
  Result := ChildNodes['empty-line'].Text;
end;

function TXMLCiteType.Get_Subtitle: IXMLPType;
begin
  Result := ChildNodes['subtitle'] as IXMLPType;
end;

function TXMLCiteType.Get_Table: IXMLTableType;
begin
  Result := ChildNodes['table'] as IXMLTableType;
end;

function TXMLCiteType.Get_Textauthor: IXMLPTypeList;
begin
  Result := FTextauthor;
end;

{ TXMLTableType }

procedure TXMLTableType.AfterConstruction;
begin
  RegisterChildNode('tr', TXMLTr);
  ItemTag := 'tr';
  ItemInterface := IXMLTr;
  inherited;
end;

function TXMLTableType.Get_Tr(Index: Integer): IXMLTr;
begin
  if List.Count > 0 then Result := List[Index] as IXMLTr;
end;

function TXMLTableType.Add: IXMLTr;
begin
  Result := AddItem(-1) as IXMLTr;
end;

function TXMLTableType.Insert(const Index: Integer): IXMLTr;
begin
  Result := AddItem(Index) as IXMLTr;
end;

{ TXMLTr }

procedure TXMLTr.AfterConstruction;
begin
  RegisterChildNode('td', TXMLPType);
  ItemTag := 'td';
  ItemInterface := IXMLPTypeList;
  inherited;
end;

function TXMLTr.Get_Align: WideString;
begin
  Result := AttributeNodes['align'].Text;
end;

procedure TXMLTr.Set_Align(Value: WideString);
begin
  SetAttribute('align', Value);
end;

function TXMLTr.Get_Td(Index: Integer): IXMLPTypeList;
begin
  if List.Count > 0 then Result := List[Index] as IXMLPTypeList;
end;

function TXMLTr.Add: IXMLPType;
begin
  Result := AddItem(-1) as IXMLPType;
end;

function TXMLTr.Insert(const Index: Integer): IXMLPType;
begin
  Result := AddItem(Index) as IXMLPType;
end;

{ TXMLStanza }

procedure TXMLStanza.AfterConstruction;
begin
  RegisterChildNode('title', TXMLTitleType);
  RegisterChildNode('subtitle', TXMLPType);
  FV := CreateCollection(TXMLPTypeList, IXMLPType, 'v') as IXMLPTypeList;
  inherited;
end;

function TXMLStanza.Get_xmlLang: WideString;
begin
  Result := AttributeNodes['xml:lang'].Text;
end;

procedure TXMLStanza.Set_xmlLang(Value: WideString);
begin
  SetAttribute('xml:lang', Value);
end;

function TXMLStanza.Get_Title: IXMLTitleType;
begin
  Result := ChildNodes['title'] as IXMLTitleType;
end;

function TXMLStanza.Get_Subtitle: IXMLPType;
begin
  Result := ChildNodes['subtitle'] as IXMLPType;
end;

function TXMLStanza.Get_V: IXMLPTypeList;
begin
  Result := FV;
end;

{ TXMLStanzaList }

function TXMLStanzaList.Add: IXMLStanza;
begin
  Result := AddItem(-1) as IXMLStanza;
end;

function TXMLStanzaList.Insert(const Index: Integer): IXMLStanza;
begin
  Result := AddItem(Index) as IXMLStanza;
end;
function TXMLStanzaList.Get_Item(Index: Integer): IXMLStanza;
begin
  if List.Count > 0 then Result := List[Index] as IXMLStanza;
end;

{ TXMLDateType }

function TXMLDateType.Get_Value: WideString;
begin
  Result := AttributeNodes['value'].Text;
end;

procedure TXMLDateType.Set_Value(Value: WideString);
begin
  SetAttribute('value', Value);
end;

function TXMLDateType.Get_xmlLang: WideString;
begin
  Result := AttributeNodes['xml:lang'].Text;
end;

procedure TXMLDateType.Set_xmlLang(Value: WideString);
begin
  SetAttribute('xml:lang', Value);
end;

{ TXMLCoverpage }

procedure TXMLCoverpage.AfterConstruction;
begin
  RegisterChildNode('image', TXMLImageType);
  ItemTag := 'image';
  ItemInterface := IXMLImageType;
  inherited;
end;

function TXMLCoverpage.Get_ImageList(Index: Integer): IXMLImageType;
begin
    if List.Count > 0 then Result := List[Index] as IXMLImageType;
end;

function TXMLCoverpage.Add: IXMLImageType;
begin
  Result := AddItem(-1) as IXMLImageType;
end;

function TXMLCoverpage.Insert(const Index: Integer): IXMLImageType;
begin
  Result := AddItem(Index) as IXMLImageType;
end;

{ TXMLImageType }

function TXMLImageType.Get_xlinkType: WideString;
begin
  Result := GetAttributeNS('type', 'http://www.w3.org/1999/xlink');
end;

procedure TXMLImageType.Set_xlinkType(Value: WideString);
begin
  SetAttributeNS('type', 'http://www.w3.org/1999/xlink', Value);
end;

function TXMLImageType.Get_xlinkHref: WideString;
begin
  Result := GetAttributeNS('href', 'http://www.w3.org/1999/xlink');
end;

procedure TXMLImageType.Set_xlinkHref(Value: WideString);
begin
  SetAttributeNS('href', 'http://www.w3.org/1999/xlink', Value);
end;

function TXMLImageType.Get_Alt: WideString;
begin
  Result := AttributeNodes['alt'].Text;
end;

procedure TXMLImageType.Set_Alt(Value: WideString);
begin
  SetAttribute('alt', Value);
end;

{ TXMLImageTypeList }

function TXMLImageTypeList.Add: IXMLImageType;
begin
  Result := AddItem(-1) as IXMLImageType;
end;

function TXMLImageTypeList.Insert(const Index: Integer): IXMLImageType;
begin
  Result := AddItem(Index) as IXMLImageType;
end;
function TXMLImageTypeList.Get_Item(Index: Integer): IXMLImageType;
begin
  if List.Count > 0 then Result := List[Index] as IXMLImageType;
end;

{ TXMLSequenceType }

procedure TXMLSequenceType.AfterConstruction;
begin
  RegisterChildNode('sequence', TXMLSequenceType);
  ItemTag := 'sequence';
  ItemInterface := IXMLSequenceType;
  inherited;
end;

function TXMLSequenceType.Get_Name: WideString;
begin
  Result := AttributeNodes['name'].Text;
end;

procedure TXMLSequenceType.Set_Name(Value: WideString);
begin
  SetAttribute('name', Value);
end;

function TXMLSequenceType.Get_Number: Integer;
var
  SourceVariant: OleVariant;
  SourceType: TVarType;
begin
  SourceVariant := AttributeNodes['number'].NodeValue;
  SourceType := TVarData(SourceVariant).VType;
  if (SourceType and varNull <> varNull) then
  begin
    Result := SourceVariant;
  end
  else
  begin
    Result := 0;
  end;
end;

procedure TXMLSequenceType.Set_Number(Value: Integer);
begin
  SetAttribute('number', Value);
end;

function TXMLSequenceType.Get_xmlLang: WideString;
begin
  Result := AttributeNodes['xml:lang'].Text;
end;

procedure TXMLSequenceType.Set_xmlLang(Value: WideString);
begin
  SetAttribute('xml:lang', Value);
end;

function TXMLSequenceType.Get_Sequence(Index: Integer): IXMLSequenceType;
begin
  if List.Count > 0 then Result := List[Index] as IXMLSequenceType;
end;

function TXMLSequenceType.Add: IXMLSequenceType;
begin
  Result := AddItem(-1) as IXMLSequenceType;
end;

function TXMLSequenceType.Insert(const Index: Integer): IXMLSequenceType;
begin
  Result := AddItem(Index) as IXMLSequenceType;
end;

{ TXMLSequenceTypeList }

function TXMLSequenceTypeList.Add: IXMLSequenceType;
begin
  Result := AddItem(-1) as IXMLSequenceType;
end;

function TXMLSequenceTypeList.Insert(const Index: Integer): IXMLSequenceType;
begin
  Result := AddItem(Index) as IXMLSequenceType;
end;
function TXMLSequenceTypeList.Get_Item(Index: Integer): IXMLSequenceType;
begin
  if List.Count > 0 then Result := List[Index] as IXMLSequenceType;
end;

{ TXMLDocumentinfo }

procedure TXMLDocumentinfo.AfterConstruction;
begin
  RegisterChildNode('author', TXMLAuthorType);
  RegisterChildNode('program-used', TXMLTextFieldType);
  RegisterChildNode('date', TXMLDateType);
  RegisterChildNode('src-ocr', TXMLTextFieldType);
  RegisterChildNode('history', TXMLAnnotationType);
  FAuthor := CreateCollection(TXMLAuthorTypeList, IXMLAuthorType, 'author') as IXMLAuthorTypeList;
  FSrcurl := CreateCollection(TXMLString_List, IXMLNode, 'src-url') as IXMLString_List;
  inherited;
end;

function TXMLDocumentinfo.Get_Author: IXMLAuthorTypeList;
begin
  Result := FAuthor;
end;

function TXMLDocumentinfo.Get_Programused: IXMLTextFieldType;
begin
  Result := ChildNodes['program-used'] as IXMLTextFieldType;
end;

function TXMLDocumentinfo.Get_Date: IXMLDateType;
begin
  Result := ChildNodes['date'] as IXMLDateType;
end;

function TXMLDocumentinfo.Get_Srcurl: IXMLString_List;
begin
  Result := FSrcurl;
end;

function TXMLDocumentinfo.Get_Srcocr: IXMLTextFieldType;
begin
  Result := ChildNodes['src-ocr'] as IXMLTextFieldType;
end;

function TXMLDocumentinfo.Get_Id: WideString;
begin
  Result := ChildNodes['id'].Text;
end;

procedure TXMLDocumentinfo.Set_Id(Value: WideString);
begin
  ChildNodes['id'].NodeValue := Value;
end;

function TXMLDocumentinfo.Get_Version: String;
begin
  Result := ChildNodes['version'].NodeValue;
end;

procedure TXMLDocumentinfo.Set_Version(Value: String);
begin
  ChildNodes['version'].NodeValue := Value;
end;

function TXMLDocumentinfo.Get_History: IXMLAnnotationType;
begin
  Result := ChildNodes['history'] as IXMLAnnotationType;
end;

{ TXMLPublishinfo }

procedure TXMLPublishinfo.AfterConstruction;
begin
  RegisterChildNode('book-name', TXMLTextFieldType);
  RegisterChildNode('publisher', TXMLTextFieldType);
  RegisterChildNode('city', TXMLTextFieldType);
  RegisterChildNode('isbn', TXMLTextFieldType);
  RegisterChildNode('sequence', TXMLSequenceType);
  FSequence := CreateCollection(TXMLSequenceTypeList, IXMLSequenceType, 'sequence') as IXMLSequenceTypeList;
  inherited;
end;

function TXMLPublishinfo.Get_Bookname: IXMLTextFieldType;
begin
  Result := ChildNodes['book-name'] as IXMLTextFieldType;
end;

function TXMLPublishinfo.Get_Publisher: IXMLTextFieldType;
begin
  Result := ChildNodes['publisher'] as IXMLTextFieldType;
end;

function TXMLPublishinfo.Get_City: IXMLTextFieldType;
begin
  Result := ChildNodes['city'] as IXMLTextFieldType;
end;

function TXMLPublishinfo.Get_Year: WideString;
begin
  Result := ChildNodes['year'].Text;
end;

procedure TXMLPublishinfo.Set_Year(Value: WideString);
begin
  ChildNodes['year'].NodeValue := Value;
end;

function TXMLPublishinfo.Get_Isbn: IXMLTextFieldType;
begin
  Result := ChildNodes['isbn'] as IXMLTextFieldType;
end;

function TXMLPublishinfo.Get_Sequence: IXMLSequenceTypeList;
begin
  Result := FSequence;
end;

{ TXMLCustominfo }

function TXMLCustominfo.Get_Infotype: WideString;
begin
  Result := AttributeNodes['info-type'].Text;
end;

procedure TXMLCustominfo.Set_Infotype(Value: WideString);
begin
  SetAttribute('info-type', Value);
end;

{ TXMLCustominfoList }

function TXMLCustominfoList.Add: IXMLCustominfo;
begin
  Result := AddItem(-1) as IXMLCustominfo;
end;

function TXMLCustominfoList.Insert(const Index: Integer): IXMLCustominfo;
begin
  Result := AddItem(Index) as IXMLCustominfo;
end;
function TXMLCustominfoList.Get_Item(Index: Integer): IXMLCustominfo;
begin
  if List.Count > 0 then Result := List[Index] as IXMLCustominfo;
end;

{ TXMLShareInstructionType }

procedure TXMLShareInstructionType.AfterConstruction;
begin
  RegisterChildNode('part', TXMLPartShareInstructionType);
  RegisterChildNode('output-document-class', TXMLOutPutDocumentType);
  FPart := CreateCollection(TXMLPartShareInstructionTypeList, IXMLPartShareInstructionType, 'part') as IXMLPartShareInstructionTypeList;
  FOutputdocumentclass := CreateCollection(TXMLOutPutDocumentTypeList, IXMLOutPutDocumentType, 'output-document-class') as IXMLOutPutDocumentTypeList;
  inherited;
end;

function TXMLShareInstructionType.Get_Mode: WideString;
begin
  Result := AttributeNodes['mode'].Text;
end;

procedure TXMLShareInstructionType.Set_Mode(Value: WideString);
begin
  SetAttribute('mode', Value);
end;

function TXMLShareInstructionType.Get_Includeall: WideString;
begin
  Result := AttributeNodes['include-all'].Text;
end;

procedure TXMLShareInstructionType.Set_Includeall(Value: WideString);
begin
  SetAttribute('include-all', Value);
end;

function TXMLShareInstructionType.Get_Price: Single;
begin
  Result := AttributeNodes['price'].NodeValue;
end;

procedure TXMLShareInstructionType.Set_Price(Value: Single);
begin
  SetAttribute('price', Value);
end;

function TXMLShareInstructionType.Get_Currency: WideString;
begin
  Result := AttributeNodes['currency'].Text;
end;

procedure TXMLShareInstructionType.Set_Currency(Value: WideString);
begin
  SetAttribute('currency', Value);
end;

function TXMLShareInstructionType.Get_Part: IXMLPartShareInstructionTypeList;
begin
  Result := FPart;
end;

function TXMLShareInstructionType.Get_Outputdocumentclass: IXMLOutPutDocumentTypeList;
begin
  Result := FOutputdocumentclass;
end;

{ TXMLShareInstructionTypeList }

function TXMLShareInstructionTypeList.Add: IXMLShareInstructionType;
begin
  Result := AddItem(-1) as IXMLShareInstructionType;
end;

function TXMLShareInstructionTypeList.Insert(const Index: Integer): IXMLShareInstructionType;
begin
  Result := AddItem(Index) as IXMLShareInstructionType;
end;
function TXMLShareInstructionTypeList.Get_Item(Index: Integer): IXMLShareInstructionType;
begin
  if List.Count > 0 then Result := List[Index] as IXMLShareInstructionType;
end;

{ TXMLPartShareInstructionType }

function TXMLPartShareInstructionType.Get_xlinkType: WideString;
begin
  Result := GetAttributeNS('type', 'http://www.w3.org/1999/xlink');
end;

procedure TXMLPartShareInstructionType.Set_xlinkType(Value: WideString);
begin
  SetAttributeNS('type', 'http://www.w3.org/1999/xlink', Value);
end;

function TXMLPartShareInstructionType.Get_xlinkHref: WideString;
begin
  Result := GetAttributeNS('href', 'http://www.w3.org/1999/xlink');
end;

procedure TXMLPartShareInstructionType.Set_xlinkHref(Value: WideString);
begin
  SetAttributeNS('href', 'http://www.w3.org/1999/xlink', Value);
end;

function TXMLPartShareInstructionType.Get_Include: WideString;
begin
  Result := AttributeNodes['include'].Text;
end;

procedure TXMLPartShareInstructionType.Set_Include(Value: WideString);
begin
  SetAttribute('include', Value);
end;

{ TXMLPartShareInstructionTypeList }

function TXMLPartShareInstructionTypeList.Add: IXMLPartShareInstructionType;
begin
  Result := AddItem(-1) as IXMLPartShareInstructionType;
end;

function TXMLPartShareInstructionTypeList.Insert(const Index: Integer): IXMLPartShareInstructionType;
begin
  Result := AddItem(Index) as IXMLPartShareInstructionType;
end;
function TXMLPartShareInstructionTypeList.Get_Item(Index: Integer): IXMLPartShareInstructionType;
begin
  if List.Count > 0 then Result := List[Index] as IXMLPartShareInstructionType;
end;

{ TXMLOutPutDocumentType }

procedure TXMLOutPutDocumentType.AfterConstruction;
begin
  RegisterChildNode('part', TXMLPartShareInstructionType);
  ItemTag := 'part';
  ItemInterface := IXMLPartShareInstructionType;
  inherited;
end;

function TXMLOutPutDocumentType.Get_Name: WideString;
begin
  Result := AttributeNodes['name'].Text;
end;

procedure TXMLOutPutDocumentType.Set_Name(Value: WideString);
begin
  SetAttribute('name', Value);
end;

function TXMLOutPutDocumentType.Get_Create: WideString;
begin
  Result := AttributeNodes['create'].Text;
end;

procedure TXMLOutPutDocumentType.Set_Create(Value: WideString);
begin
  SetAttribute('create', Value);
end;

function TXMLOutPutDocumentType.Get_Price: Single;
begin
  Result := AttributeNodes['price'].NodeValue;
end;

procedure TXMLOutPutDocumentType.Set_Price(Value: Single);
begin
  SetAttribute('price', Value);
end;

function TXMLOutPutDocumentType.Get_Part(Index: Integer): IXMLPartShareInstructionType;
begin
  if List.Count > 0 then Result := List[Index] as IXMLPartShareInstructionType;
end;

function TXMLOutPutDocumentType.Add: IXMLPartShareInstructionType;
begin
  Result := AddItem(-1) as IXMLPartShareInstructionType;
end;

function TXMLOutPutDocumentType.Insert(const Index: Integer): IXMLPartShareInstructionType;
begin
  Result := AddItem(Index) as IXMLPartShareInstructionType;
end;

{ TXMLOutPutDocumentTypeList }

function TXMLOutPutDocumentTypeList.Add: IXMLOutPutDocumentType;
begin
  Result := AddItem(-1) as IXMLOutPutDocumentType;
end;

function TXMLOutPutDocumentTypeList.Insert(const Index: Integer): IXMLOutPutDocumentType;
begin
  Result := AddItem(Index) as IXMLOutPutDocumentType;
end;
function TXMLOutPutDocumentTypeList.Get_Item(Index: Integer): IXMLOutPutDocumentType;
begin
  if List.Count > 0 then Result := List[Index] as IXMLOutPutDocumentType;
end;

{ TXMLBody }

procedure TXMLBody.AfterConstruction;
begin
  RegisterChildNode('image', TXMLImageType);
  RegisterChildNode('title', TXMLTitleType);
  RegisterChildNode('epigraph', TXMLEpigraphType);
  RegisterChildNode('section', TXMLSectionType);
  FEpigraph := CreateCollection(TXMLEpigraphTypeList, IXMLEpigraphType, 'epigraph') as IXMLEpigraphTypeList;
  FSection := CreateCollection(TXMLSectionTypeList, IXMLSectionType, 'section') as IXMLSectionTypeList;
  inherited;
end;

function TXMLBody.Get_Name: WideString;
begin
  Result := AttributeNodes['name'].Text;
end;

procedure TXMLBody.Set_Name(Value: WideString);
begin
  SetAttribute('name', Value);
end;

function TXMLBody.Get_xmlLang: WideString;
begin
  Result := AttributeNodes['xml:lang'].Text;
end;

procedure TXMLBody.Set_xmlLang(Value: WideString);
begin
  SetAttribute('xml:lang', Value);
end;

function TXMLBody.Get_Image: IXMLImageType;
begin
  Result := ChildNodes['image'] as IXMLImageType;
end;

function TXMLBody.Get_Title: IXMLTitleType;
begin
  Result := ChildNodes['title'] as IXMLTitleType;
end;

function TXMLBody.Get_Epigraph: IXMLEpigraphTypeList;
begin
  Result := FEpigraph;
end;

function TXMLBody.Get_Section: IXMLSectionTypeList;
begin
  Result := FSection;
end;

{ TXMLBodyList }

function TXMLBodyList.Add: IXMLBody;
begin
  Result := AddItem(-1) as IXMLBody;
end;

function TXMLBodyList.Insert(const Index: Integer): IXMLBody;
begin
  Result := AddItem(Index) as IXMLBody;
end;
function TXMLBodyList.Get_Item(Index: Integer): IXMLBody;
begin
  if List.Count > 0 then Result := List[Index] as IXMLBody;
end;

{ TXMLSectionType }

procedure TXMLSectionType.AfterConstruction;
begin
  RegisterChildNode('title', TXMLTitleType);
  RegisterChildNode('epigraph', TXMLEpigraphType);
  RegisterChildNode('image', TXMLImageType);
  RegisterChildNode('annotation', TXMLAnnotationType);
  RegisterChildNode('section', TXMLSectionType);
  RegisterChildNode('p', TXMLPType);
  RegisterChildNode('poem', TXMLPoemType);
  RegisterChildNode('subtitle', TXMLPType);
  RegisterChildNode('cite', TXMLCiteType);
  RegisterChildNode('table', TXMLTableType);
  FEpigraph := CreateCollection(TXMLEpigraphTypeList, IXMLEpigraphType, 'epigraph') as IXMLEpigraphTypeList;
  FSection := CreateCollection(TXMLSectionTypeList, IXMLSectionType, 'section') as IXMLSectionTypeList;
  inherited;
end;

function TXMLSectionType.Get_Id: WideString;
begin
  Result := AttributeNodes['id'].Text;
end;

procedure TXMLSectionType.Set_Id(Value: WideString);
begin
  SetAttribute('id', Value);
end;

function TXMLSectionType.Get_xmlLang: WideString;
begin
  Result := AttributeNodes['xml:lang'].Text;
end;

procedure TXMLSectionType.Set_xmlLang(Value: WideString);
begin
  SetAttribute('xml:lang', Value);
end;

function TXMLSectionType.Get_Title: IXMLTitleType;
begin
  Result := ChildNodes['title'] as IXMLTitleType;
end;

function TXMLSectionType.Get_Epigraph: IXMLEpigraphTypeList;
begin
  Result := FEpigraph;
end;

function TXMLSectionType.Get_Image: IXMLImageType;
begin
  Result := ChildNodes['image'] as IXMLImageType;
end;

function TXMLSectionType.Get_Annotation: IXMLAnnotationType;
begin
  Result := ChildNodes['annotation'] as IXMLAnnotationType;
end;

function TXMLSectionType.Get_Section: IXMLSectionTypeList;
begin
  Result := FSection;
end;

function TXMLSectionType.Get_P: IXMLPType;
begin
  Result := ChildNodes['p'] as IXMLPType;
end;

function TXMLSectionType.Get_Poem: IXMLPoemType;
begin
  Result := ChildNodes['poem'] as IXMLPoemType;
end;

function TXMLSectionType.Get_Subtitle: IXMLPType;
begin
  Result := ChildNodes['subtitle'] as IXMLPType;
end;

function TXMLSectionType.Get_Cite: IXMLCiteType;
begin
  Result := ChildNodes['cite'] as IXMLCiteType;
end;

function TXMLSectionType.Get_Emptyline: WideString;
begin
  Result := ChildNodes['empty-line'].Text;
end;

procedure TXMLSectionType.Set_Emptyline(Value: WideString);
begin
  ChildNodes['empty-line'].NodeValue := Value;
end;

function TXMLSectionType.Get_Table: IXMLTableType;
begin
  Result := ChildNodes['table'] as IXMLTableType;
end;

{ TXMLSectionTypeList }

function TXMLSectionTypeList.Add: IXMLSectionType;
begin
  Result := AddItem(-1) as IXMLSectionType;
end;

function TXMLSectionTypeList.Insert(const Index: Integer): IXMLSectionType;
begin
  Result := AddItem(Index) as IXMLSectionType;
end;
function TXMLSectionTypeList.Get_Item(Index: Integer): IXMLSectionType;
begin
  if List.Count > 0 then Result := List[Index] as IXMLSectionType;
end;

{ TXMLBinary }

function TXMLBinary.Get_Contenttype: WideString;
begin
  Result := AttributeNodes['content-type'].Text;
end;

procedure TXMLBinary.Set_Contenttype(Value: WideString);
begin
  SetAttribute('content-type', Value);
end;

function TXMLBinary.Get_Id: WideString;
begin
  Result := AttributeNodes['id'].Text;
end;

procedure TXMLBinary.Set_Id(Value: WideString);
begin
  SetAttribute('id', Value);
end;


{ TXMLBinaryList }

function TXMLBinaryList.Add: IXMLBinary;
begin
  Result := AddItem(-1) as IXMLBinary;
end;

function TXMLBinaryList.Insert(const Index: Integer): IXMLBinary;
begin
  Result := AddItem(Index) as IXMLBinary;
end;
function TXMLBinaryList.Get_Item(Index: Integer): IXMLBinary;
begin
  if List.Count > 0 then Result := List[Index] as IXMLBinary;
end;

{ TXMLPType }

function TXMLPType.Get_Id: WideString;
begin
  Result := AttributeNodes['id'].Text;
end;

procedure TXMLPType.Set_Id(Value: WideString);
begin
  SetAttribute('id', Value);
end;

function TXMLPType.Get_Style: WideString;
begin
  Result := AttributeNodes['style'].Text;
end;

procedure TXMLPType.Set_Style(Value: WideString);
begin
  SetAttribute('style', Value);
end;

function TXMLPType.Get_Styles: IXMLStyleType;
begin
end;

function TXMLPType.Get_OnlyText: WideString;

  function AddText(Node: IXMLNode): WideString;
  var
    Index: Integer;
  begin
    if (Node.NodeType in [ntText, ntCData]) then
      Result := Result + Node.Text;
    for Index := 0 to Node.ChildNodes.Count - 1 do
      Result := AddText(Node.ChildNodes[Index]);
  end;

begin
  Result := AddText(Self);
end;

{ TXMLPTypeList }

function TXMLPTypeList.Add: IXMLPType;
begin
  Result := AddItem(-1) as IXMLPType;
end;

function TXMLPTypeList.Insert(const Index: Integer): IXMLPType;
begin
  Result := AddItem(Index) as IXMLPType;
end;

function TXMLPTypeList.Get_Item(Index: Integer): IXMLPType;
begin
  if List.Count > 0 then Result := List[Index] as IXMLPType;
end;

{ TXMLNamedStyleType }

procedure TXMLNamedStyleType.AfterConstruction;
begin
  RegisterChildNode('strong', TXMLStyleType);
  RegisterChildNode('emphasis', TXMLStyleType);
  RegisterChildNode('style', TXMLNamedStyleType);
  RegisterChildNode('a', TXMLLinkType);
  RegisterChildNode('strikethrough', TXMLStyleType);
  RegisterChildNode('sub', TXMLStyleType);
  RegisterChildNode('sup', TXMLStyleType);
  RegisterChildNode('code', TXMLStyleType);
  RegisterChildNode('image', TXMLImageType);
  inherited;
end;

function TXMLNamedStyleType.Get_xmlLang: WideString;
begin
  Result := AttributeNodes['xml:lang'].Text;
end;

procedure TXMLNamedStyleType.Set_xmlLang(Value: WideString);
begin
  SetAttribute('xml:lang', Value);
end;

function TXMLNamedStyleType.Get_Name: WideString;
begin
  Result := AttributeNodes['name'].Text;
end;

procedure TXMLNamedStyleType.Set_Name(Value: WideString);
begin
  SetAttribute('name', Value);
end;

function TXMLNamedStyleType.Get_Strong: IXMLStyleType;
begin
  Result := ChildNodes['strong'] as IXMLStyleType;
end;

function TXMLNamedStyleType.Get_Emphasis: IXMLStyleType;
begin
  Result := ChildNodes['emphasis'] as IXMLStyleType;
end;

function TXMLNamedStyleType.Get_Style: IXMLNamedStyleType;
begin
  Result := ChildNodes['style'] as IXMLNamedStyleType;
end;

function TXMLNamedStyleType.Get_A: IXMLLinkType;
begin
  Result := ChildNodes['a'] as IXMLLinkType;
end;

function TXMLNamedStyleType.Get_Strikethrough: IXMLStyleType;
begin
  Result := ChildNodes['strikethrough'] as IXMLStyleType;
end;

function TXMLNamedStyleType.Get_Sub: IXMLStyleType;
begin
  Result := ChildNodes['sub'] as IXMLStyleType;
end;

function TXMLNamedStyleType.Get_Sup: IXMLStyleType;
begin
  Result := ChildNodes['sup'] as IXMLStyleType;
end;

function TXMLNamedStyleType.Get_Code: IXMLStyleType;
begin
  Result := ChildNodes['code'] as IXMLStyleType;
end;

function TXMLNamedStyleType.Get_Image: IXMLImageType;
begin
  Result := ChildNodes['image'] as IXMLImageType;
end;

{ TXMLLinkType }

procedure TXMLLinkType.AfterConstruction;
begin
  RegisterChildNode('strong', TXMLStyleLinkType);
  RegisterChildNode('emphasis', TXMLStyleLinkType);
  RegisterChildNode('style', TXMLStyleLinkType);
  RegisterChildNode('strikethrough', TXMLStyleType);
  RegisterChildNode('sub', TXMLStyleType);
  RegisterChildNode('sup', TXMLStyleType);
  RegisterChildNode('code', TXMLStyleType);
  RegisterChildNode('image', TXMLImageType);
  inherited;
end;

function TXMLLinkType.Get_xlinkType: WideString;
begin
  Result := GetAttributeNS('type', 'http://www.w3.org/1999/xlink');
end;

procedure TXMLLinkType.Set_xlinkType(Value: WideString);
begin
  SetAttributeNS('type', 'http://www.w3.org/1999/xlink', Value);
end;

function TXMLLinkType.Get_xlinkHref: WideString;
begin
  Result := GetAttributeNS('href', 'http://www.w3.org/1999/xlink');
end;

procedure TXMLLinkType.Set_xlinkHref(Value: WideString);
begin
  SetAttributeNS('href', 'http://www.w3.org/1999/xlink', Value);
end;

function TXMLLinkType.Get_attrType: WideString;
begin
  Result := AttributeNodes['type'].Text;
end;

procedure TXMLLinkType.Set_attrType(Value: WideString);
begin
  SetAttribute('type', Value);
end;

function TXMLLinkType.Get_Strong: IXMLStyleLinkType;
begin
  Result := ChildNodes['strong'] as IXMLStyleLinkType;
end;

function TXMLLinkType.Get_Emphasis: IXMLStyleLinkType;
begin
  Result := ChildNodes['emphasis'] as IXMLStyleLinkType;
end;

function TXMLLinkType.Get_Style: IXMLStyleLinkType;
begin
  Result := ChildNodes['style'] as IXMLStyleLinkType;
end;

function TXMLLinkType.Get_Strikethrough: IXMLStyleType;
begin
  Result := ChildNodes['strikethrough'] as IXMLStyleType;
end;

function TXMLLinkType.Get_Sub: IXMLStyleType;
begin
  Result := ChildNodes['sub'] as IXMLStyleType;
end;

function TXMLLinkType.Get_Sup: IXMLStyleType;
begin
  Result := ChildNodes['sup'] as IXMLStyleType;
end;

function TXMLLinkType.Get_Code: IXMLStyleType;
begin
  Result := ChildNodes['code'] as IXMLStyleType;
end;

function TXMLLinkType.Get_Image: IXMLImageType;
begin
  Result := ChildNodes['image'] as IXMLImageType;
end;

{ TXMLStyleLinkType }

procedure TXMLStyleLinkType.AfterConstruction;
begin
  RegisterChildNode('strong', TXMLStyleLinkType);
  RegisterChildNode('emphasis', TXMLStyleLinkType);
  RegisterChildNode('style', TXMLStyleLinkType);
  inherited;
end;

function TXMLStyleLinkType.Get_Strong: IXMLStyleLinkType;
begin
  Result := ChildNodes['strong'] as IXMLStyleLinkType;
end;

function TXMLStyleLinkType.Get_Emphasis: IXMLStyleLinkType;
begin
  Result := ChildNodes['emphasis'] as IXMLStyleLinkType;
end;

function TXMLStyleLinkType.Get_Style: IXMLStyleLinkType;
begin
  Result := ChildNodes['style'] as IXMLStyleLinkType;
end;

{ TXMLGenreTypeList }

function TXMLGenreTypeList.Add(const Value: WideString): IXMLNode;
begin
  Result := AddItem(-1);
  Result.NodeValue := Value;
end;

function TXMLGenreTypeList.Insert(const Index: Integer; const Value: WideString): IXMLNode;
begin
  Result := AddItem(Index);
  Result.NodeValue := Value;
end;
function TXMLGenreTypeList.Get_Item(Index: Integer): WideString;
begin
  if List.Count > 0 then Result := List[Index].Text else Result := '';
end;

{ TXMLString_List }

function TXMLString_List.Add(const Value: WideString): IXMLNode;
begin
  Result := AddItem(-1);
  Result.NodeValue := Value;
end;

function TXMLString_List.Insert(const Index: Integer; const Value: WideString): IXMLNode;
begin
  Result := AddItem(Index);
  Result.NodeValue := Value;
end;
function TXMLString_List.Get_Item(Index: Integer): WideString;
begin
  if List.Count > 0 then Result := List[Index].Text else Result := '';
end;

end.