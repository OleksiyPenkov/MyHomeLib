
{******************************************************************************}
{                                                                              }
{                               Fiction Book Description                       }
{                                                                              }
{******************************************************************************}

unit fbd_xml;

interface

uses
  xmldom,
  XMLDoc,
  XMLIntf,
  Classes;

type

{ Forward Decls }

  IXMLFictionBookDescription = interface;
  IXMLDescription = interface;
  IXMLTitleinfoType = interface;
  IXMLAuthorType = interface;
  IXMLAuthorTypeList = interface;
  IXMLTextFieldType = interface;
  IXMLAnnotationType = interface;
  IXMLDateType = interface;
  IXMLCoverpage = interface;
  IXMLImageType = interface;
  IXMLSequenceType = interface;
  IXMLSequenceTypeList = interface;
  IXMLDocumentinfo = interface;
  IXMLPublishinfo = interface;
  IXMLCustominfo = interface;
  IXMLCustominfoList = interface;
  IXMLBinary = interface;
  IXMLBinaryList = interface;
  IXMLGenreTypeList = interface;
  IXMLString_List = interface;
  IXMLStyleType = interface;
  IXMLPType = interface;
  IXMLPTypeList = interface;
  IXMLNamedStyleType = interface;

{ IXMLFictionBook }

  IXMLFictionBookDescription = interface(IXMLNode)
    ['{AFC2B075-5F77-4BF3-ACA0-BCDC2E59E7D7}']
    { Property Accessors }
    function Get_Description: IXMLDescription;
    function Get_Binary: IXMLBinaryList;
    { Methods & Properties }
    property Description: IXMLDescription read Get_Description;
    property Binary: IXMLBinaryList read Get_Binary;
  end;

{ IXMLDescription }

  IXMLDescription = interface(IXMLNode)
    ['{EA72DB9D-A8F3-401A-B158-8FF8C7FB3A1D}']
    { Property Accessors }
    function Get_Titleinfo: IXMLTitleinfoType;
    function Get_Srctitleinfo: IXMLTitleinfoType;
    function Get_Documentinfo: IXMLDocumentinfo;
    function Get_Publishinfo: IXMLPublishinfo;
    function Get_Custominfo: IXMLCustominfoList;

    procedure Set_Custominfo(Value: IXMLCustominfoList);
    procedure Set_TitleInfo(Value: IXMLTitleinfoType);
    procedure Set_Srctitleinfo(Value: IXMLTitleinfoType);
    procedure Set_Documentinfo(Value: IXMLDocumentinfo);
    procedure Set_Publishinfo(Value: IXMLPublishinfo);

    { Methods & Properties }
    property Titleinfo: IXMLTitleinfoType read Get_Titleinfo write Set_TitleInfo;
    property Srctitleinfo: IXMLTitleinfoType read Get_Srctitleinfo write Set_Srctitleinfo;
    property Documentinfo: IXMLDocumentinfo read Get_Documentinfo write Set_Documentinfo;
    property Publishinfo: IXMLPublishinfo read Get_Publishinfo write Set_Publishinfo;
    property Custominfo: IXMLCustominfoList read Get_Custominfo write Set_Custominfo;
  end;

{ IXMLTitleinfoType }

  IXMLTitleinfoType = interface(IXMLNode)
    ['{F1E63940-9A2E-4869-B5BD-BDABB1E85396}']
    { Property Accessors }
    function Get_Genre: IXMLGenreTypeList;
    function Get_Author: IXMLAuthorTypeList;
    procedure Set_Author(Value: IXMLAuthorTypeList);
    function Get_Booktitle: IXMLTextFieldType;
    function Get_Annotation: IXMLAnnotationType;
    function Get_Keywords: IXMLTextFieldType;
    function Get_Date: IXMLDateType;
    function Get_Coverpage: IXMLCoverpage;
    function Get_Lang: WideString;
    function Get_Srclang: WideString;
    function Get_Translator: IXMLAuthorTypeList;
    procedure Set_Translator(Value: IXMLAuthorTypeList);
    function Get_Sequence: IXMLSequenceTypeList;
    procedure Set_Lang(Value: WideString);
    procedure Set_Srclang(Value: WideString);
    function Get_Udk: WideString;
    procedure Set_Udk (Value: WideString);
    function Get_Bbk: WideString;
    procedure Set_Bbk (Value: WideString);
    function Get_Grnti: WideString;
    procedure Set_Grnti (Value: WideString);
    { Methods & Properties }
    property Genre: IXMLGenreTypeList read Get_Genre;
    property Author: IXMLAuthorTypeList read Get_Author write Set_Author;
    property Booktitle: IXMLTextFieldType read Get_Booktitle;
    property Annotation: IXMLAnnotationType read Get_Annotation;
    property Keywords: IXMLTextFieldType read Get_Keywords;
    property Date: IXMLDateType read Get_Date;
    property Coverpage: IXMLCoverpage read Get_Coverpage;
    property Lang: WideString read Get_Lang write Set_Lang;
    property Srclang: WideString read Get_Srclang write Set_Srclang;
    property Translator: IXMLAuthorTypeList read Get_Translator write Set_Translator;
    property Sequence: IXMLSequenceTypeList read Get_Sequence;
    property Udk: WideString read Get_Udk write Set_Udk;
    property Bbk: WideString read Get_Bbk write Set_Bbk;
    property Grnti: WideString read Get_Grnti write Set_Grnti;
  end;

{ IXMLAuthorType }

  IXMLAuthorType = interface(IXMLNode)
    ['{3E0BDDE1-7DFB-45BE-B2BA-97B500059A10}']
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
    ['{FADD22D0-4CF8-4ABE-97A1-70EA3E8F284D}']
    { Methods & Properties }
    function Add: IXMLAuthorType;
    function Insert(const Index: Integer): IXMLAuthorType;
    function Get_Item(Index: Integer): IXMLAuthorType;
    property Items[Index: Integer]: IXMLAuthorType read Get_Item; default;
  end;

{ IXMLTextFieldType }

  IXMLTextFieldType = interface(IXMLNode)
    ['{27D40929-838A-4A2D-865C-06A7603A8931}']
    { Property Accessors }
    function Get_xmlLang: WideString;
    procedure Set_xmlLang(Value: WideString);
    { Methods & Properties }
    property xmlLang: WideString read Get_xmlLang write Set_xmlLang;
  end;

{ IXMLAnnotationType }

  IXMLAnnotationType = interface(IXMLNode)
    ['{DE9DD154-761F-4FFA-9CCA-50D6790E77FA}']
    { Property Accessors }
    function Get_Id: WideString;
    function Get_xmlLang: WideString;
    function Get_P: IXMLPTypeList;
    function Get_Subtitle: IXMLPType;
    function Get_Emptyline: WideString;
    procedure Set_Id(Value: WideString);
    procedure Set_xmlLang(Value: WideString);
    { Methods & Properties }
    property Id: WideString read Get_Id write Set_Id;
    property xmlLang: WideString read Get_xmlLang write Set_xmlLang;
    property P: IXMLPTypeList read Get_P;
    property Subtitle: IXMLPType read Get_Subtitle;
    property Emptyline: WideString read Get_Emptyline;
  end;

{ IXMLDateType }

  IXMLDateType = interface(IXMLNode)
    ['{E0B9A376-558B-47A7-88B6-BE24A32F9F61}']
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
    ['{5EC73786-8BF2-4261-BA00-51233348BF30}']
    { Property Accessors }
    function Get_ImageList(Index: Integer): IXMLImageType;
    { Methods & Properties }
    function Add: IXMLImageType;
    function Insert(const Index: Integer): IXMLImageType;
    property ImageList[Index: Integer]: IXMLImageType read Get_ImageList; default;
  end;

{ IXMLImageType }

  IXMLImageType = interface(IXMLNode)
    ['{2B315BEF-5ED4-473B-83FA-E1C3FB43AA24}']
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
    ['{A21F9411-96AE-427E-8F1D-3F66A768FB51}']
    { Methods & Properties }
    function Add: IXMLImageType;
    function Insert(const Index: Integer): IXMLImageType;
    function Get_Item(Index: Integer): IXMLImageType;
    property Items[Index: Integer]: IXMLImageType read Get_Item; default;
  end;

{ IXMLSequenceType }

  IXMLSequenceType = interface(IXMLNodeCollection)
    ['{8F9B5F9C-25D4-4EEF-8798-06948ADBB383}']
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
    ['{7DD67339-796D-49E1-AC6C-2A36E31263FC}']
    { Methods & Properties }
    function Add: IXMLSequenceType;
    function Insert(const Index: Integer): IXMLSequenceType;
    function Get_Item(Index: Integer): IXMLSequenceType;
    property Items[Index: Integer]: IXMLSequenceType read Get_Item; default;
  end;

{ IXMLDocumentinfo }

  IXMLDocumentinfo = interface(IXMLNode)
    ['{9572FD35-C3D1-46FB-88C2-BE0C215FA503}']
    { Property Accessors }
    function Get_Author: IXMLAuthorTypeList;
    procedure Set_Author (Value: IXMLAuthorTypeList);
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
    property Author: IXMLAuthorTypeList read Get_Author write Set_Author;
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
    ['{7D9C2221-BFF0-4DB6-B0AF-2B9D1168C79B}']
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
    ['{78FC80C8-D1BE-43DF-AAB6-6D87615B1929}']
    { Property Accessors }
    function Get_Infotype: WideString;
    procedure Set_Infotype(Value: WideString);
    { Methods & Properties }
    property Infotype: WideString read Get_Infotype write Set_Infotype;
  end;

{ IXMLCustominfoList }

  IXMLCustominfoList = interface(IXMLNodeCollection)
    ['{390A0586-A08E-4DC2-B9EB-D0510FE15FBA}']
    { Methods & Properties }
    function Add: IXMLCustominfo;
    function Insert(const Index: Integer): IXMLCustominfo;
    function Get_Item(Index: Integer): IXMLCustominfo;
    property Items[Index: Integer]: IXMLCustominfo read Get_Item; default;
  end;

{ IXMLBinary }

  IXMLBinary = interface(IXMLNode)
    ['{69F0F01E-7493-4472-9B70-06429BF59B6B}']
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
    ['{E8E0D6A4-98BA-4C39-A322-1C252C2CDDD2}']
    { Methods & Properties }
    function Add: IXMLBinary;
    function Insert(const Index: Integer): IXMLBinary;
    function Get_Item(Index: Integer): IXMLBinary;
    property Items[Index: Integer]: IXMLBinary read Get_Item; default;
  end;

{ IXMLPType }

  IXMLPType = interface(IXMLNode)
    ['{FD4E17A5-3133-484A-89F2-563B6CC55764}']
    { Property Accessors }
    function Get_Id: WideString;
    function Get_Style: WideString;
    function Get_OnlyText: WideString;
    procedure Set_Id(Value: WideString);
    procedure Set_Style(Value: WideString);
    { Methods & Properties }
    property Id: WideString read Get_Id write Set_Id;
    property Style: WideString read Get_Style write Set_Style;
    property OnlyText: WideString read Get_OnlyText;
  end;

{ IXMLPTypeList }

  IXMLPTypeList = interface(IXMLNodeCollection)
    ['{54B10065-FB8D-416F-9A8B-DC9A72FB7D11}']
    { Methods & Properties }
    function Add: IXMLPType;
    function Insert(const Index: Integer): IXMLPType;
    function Get_Item(Index: Integer): IXMLPType;
    property Items[Index: Integer]: IXMLPType read Get_Item; default;
  end;

{ IXMLGenreTypeList }

  IXMLGenreTypeList = interface(IXMLNodeCollection)
    ['{80B2C43A-D37B-4B4C-8CCE-26487FE12AC8}']
    { Methods & Properties }
    function Add(const Value: WideString): IXMLNode;
    function Insert(const Index: Integer; const Value: WideString): IXMLNode;
    function Get_Item(Index: Integer): WideString;
    property Items[Index: Integer]: WideString read Get_Item; default;
  end;

{ IXMLString_List }

  IXMLString_List = interface(IXMLNodeCollection)
    ['{6BA6727A-938B-4CB8-AB31-55227643BA2F}']
    { Methods & Properties }
    function Add(const Value: WideString): IXMLNode;
    function Insert(const Index: Integer; const Value: WideString): IXMLNode;
    function Get_Item(Index: Integer): WideString;
    property Items[Index: Integer]: WideString read Get_Item; default;
  end;

{ IXMLStyleType }

  IXMLStyleType = interface(IXMLNode)
    ['{6692A4A3-1964-4333-A069-AF9183ACEA6D}']
    { Property Accessors }
    function Get_xmlLang: WideString;
    function Get_Strong: IXMLStyleType;
    function Get_Emphasis: IXMLStyleType;
    function Get_Style: IXMLNamedStyleType;
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
    property Strikethrough: IXMLStyleType read Get_Strikethrough;
    property Sub: IXMLStyleType read Get_Sub;
    property Sup: IXMLStyleType read Get_Sup;
    property Code: IXMLStyleType read Get_Code;
    property Image: IXMLImageType read Get_Image;
  end;

  { IXMLNamedStyleType }

  IXMLNamedStyleType = interface(IXMLNode)
    ['{A6F94AEC-CFB7-497D-BDB6-FAC7263D5415}']
    { Property Accessors }
    function Get_xmlLang: WideString;
    function Get_Name: WideString;
    function Get_Strong: IXMLStyleType;
    function Get_Emphasis: IXMLStyleType;
    function Get_Style: IXMLNamedStyleType;
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
    property Strikethrough: IXMLStyleType read Get_Strikethrough;
    property Sub: IXMLStyleType read Get_Sub;
    property Sup: IXMLStyleType read Get_Sup;
    property Code: IXMLStyleType read Get_Code;
    property Image: IXMLImageType read Get_Image;
  end;



{ Forward Decls }

  TXMLFictionBook = class;
  TXMLDescription = class;
  TXMLTitleinfoType = class;
  TXMLAuthorType = class;
  TXMLAuthorTypeList = class;
  TXMLTextFieldType = class;
  TXMLAnnotationType = class;
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
  TXMLBinary = class;
  TXMLBinaryList = class;
  TXMLGenreTypeList = class;
  TXMLString_List = class;
  TXMLPType = class;
  TXMLPTypeList = class;
  TXMLNamedStyleType = class;
  TXMLStyleType = class;

{ TXMLFictionBook }

  TXMLFictionBook = class(TXMLNode, IXMLFictionBookDescription)
  private
    FBinary: IXMLBinaryList;
  protected
    { IXMLFictionBook }
    function Get_Description: IXMLDescription;
    function Get_Binary: IXMLBinaryList;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLDescription }

  TXMLDescription = class(TXMLNode, IXMLDescription)
  private
    FCustominfo: IXMLCustominfoList;
//    FTitleInfo:  IXMLTitleinfoType;
//    FDocumentInfo: IXMLDocumentinfo;
//    FPublishInfo: IXMLPublishinfo;
  protected
    { IXMLDescription }
    function Get_Titleinfo: IXMLTitleinfoType;
    function Get_Srctitleinfo: IXMLTitleinfoType;
    function Get_Documentinfo: IXMLDocumentinfo;
    function Get_Publishinfo: IXMLPublishinfo;
    function Get_Custominfo: IXMLCustominfoList;

    procedure Set_Custominfo(Value: IXMLCustominfoList);
    procedure Set_TitleInfo(Value: IXMLTitleinfoType);
    procedure Set_Srctitleinfo(Value: IXMLTitleinfoType);
    procedure Set_Documentinfo(Value: IXMLDocumentinfo);
    procedure Set_Publishinfo(Value: IXMLPublishinfo);

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
    procedure Set_Author (Value: IXMLAuthorTypeList);
    function Get_Author: IXMLAuthorTypeList;
    function Get_Booktitle: IXMLTextFieldType;
    function Get_Annotation: IXMLAnnotationType;
    function Get_Keywords: IXMLTextFieldType;
    function Get_Date: IXMLDateType;
    function Get_Coverpage: IXMLCoverpage;
    function Get_Lang: WideString;
    function Get_Srclang: WideString;
    function Get_Translator: IXMLAuthorTypeList;
    procedure Set_Translator(Value: IXMLAuthorTypeList);
    function Get_Sequence: IXMLSequenceTypeList;
    procedure Set_Lang(Value: WideString);
    procedure Set_Srclang(Value: WideString);

    function Get_Udk: WideString;
    procedure Set_Udk (Value: WideString);
    function Get_Bbk: WideString;
    procedure Set_Bbk (Value: WideString);
    function Get_Grnti: WideString;
    procedure Set_Grnti (Value: WideString);
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
    function Get_Subtitle: IXMLPType;
    function Get_Emptyline: WideString;
    procedure Set_Id(Value: WideString);
    procedure Set_xmlLang(Value: WideString);
  public
    procedure AfterConstruction; override;
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
    procedure Set_Author (Value: IXMLAuthorTypeList);
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

{ TXMLStyleType }

  TXMLStyleType = class(TXMLNode, IXMLStyleType)
  protected
    { IXMLStyleType }
    function Get_xmlLang: WideString;
    function Get_Strong: IXMLStyleType;
    function Get_Emphasis: IXMLStyleType;
    function Get_Style: IXMLNamedStyleType;
    function Get_Strikethrough: IXMLStyleType;
    function Get_Sub: IXMLStyleType;
    function Get_Sup: IXMLStyleType;
    function Get_Code: IXMLStyleType;
    function Get_Image: IXMLImageType;
    procedure Set_xmlLang(Value: WideString);
  public
    procedure AfterConstruction; override;
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


{ Global Functions }

function GetFictionBook(Doc: IXMLDocument): IXMLFictionBookDescription;
function NewFictionBook: IXMLFictionBookDescription;
function LoadFictionBook(const FileName: WideString): IXMLFictionBookDescription; overload;
function LoadFictionBook(const Stream: TStream): IXMLFictionBookDescription; overload;

const
  TargetNamespace = 'http://www.gribuser.ru/xml/fictionbook/2.0';

implementation

{ Global Functions }

function GetFictionBook(Doc: IXMLDocument): IXMLFictionBookDescription;
begin
  Result := Doc.GetDocBinding('FictionBook', TXMLFictionBook, TargetNamespace) as IXMLFictionBookDescription;
end;

function NewFictionBook: IXMLFictionBookDescription;
begin
  Result := NewXMLDocument.GetDocBinding('FictionBook', TXMLFictionBook, TargetNamespace) as IXMLFictionBookDescription;
end;

function LoadFictionBook(const FileName: WideString): IXMLFictionBookDescription; overload;
begin
  Result := LoadXMLDocument(FileName).GetDocBinding('FictionBook', TXMLFictionBook, TargetNamespace) as IXMLFictionBookDescription;
end;

function LoadFictionBook(const Stream: TStream): IXMLFictionBookDescription; overload;
var
  Doc: IXMLDocument;
begin
  Doc := TXMLDocument.Create(nil);
  Doc.LoadFromStream(Stream);
  Result := Doc.GetDocBinding('FictionBook', TXMLFictionBook, TargetNamespace) as IXMLFictionBookDescription;
end;

{ TXMLFictionBook }

procedure TXMLFictionBook.AfterConstruction;
begin
  RegisterChildNode('description', TXMLDescription);
  RegisterChildNode('binary', TXMLBinary);
  FBinary := CreateCollection(TXMLBinaryList, IXMLBinary, 'binary') as IXMLBinaryList;
  inherited;
end;

function TXMLFictionBook.Get_Description: IXMLDescription;
begin
  Result := ChildNodes['description'] as IXMLDescription;
end;


function TXMLFictionBook.Get_Binary: IXMLBinaryList;
begin
  Result := FBinary;
end;

{ TXMLDescription }

procedure TXMLDescription.AfterConstruction;
begin
  RegisterChildNode('title-info', TXMLTitleinfoType);
  RegisterChildNode('src-title-info', TXMLTitleinfoType);
  RegisterChildNode('document-info', TXMLDocumentinfo);
  RegisterChildNode('publish-info', TXMLPublishinfo);
  RegisterChildNode('custom-info', TXMLCustominfo);
  FCustominfo := CreateCollection(TXMLCustominfoList, IXMLCustominfo, 'custom-info') as IXMLCustominfoList;
  inherited;
end;

function TXMLDescription.Get_Titleinfo: IXMLTitleinfoType;
begin
  Result := ChildNodes['title-info'] as IXMLTitleinfoType;
end;

procedure TXMLDescription.Set_Custominfo(Value: IXMLCustominfoList);
begin
  FCustominfo := Value;
end;

procedure TXMLDescription.Set_Documentinfo(Value: IXMLDocumentinfo);
begin
  (ChildNodes['document-info'] as IXMLDocumentinfo).NodeValue := Value;
end;

procedure TXMLDescription.Set_Publishinfo(Value: IXMLPublishinfo);
begin
  (ChildNodes['publish-info'] as IXMLPublishinfo).NodeValue := Value;
end;

procedure TXMLDescription.Set_Srctitleinfo(Value: IXMLTitleinfoType);
begin
  (ChildNodes['src-title-info'] as IXMLTitleinfoType).NodeValue := Value;
end;

procedure TXMLDescription.Set_TitleInfo(Value: IXMLTitleinfoType);
begin
  (ChildNodes['title-info'] as IXMLTitleinfoType).NodeValue := Value;
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

function TXMLTitleinfoType.Get_Grnti: WideString;
begin
   Result := ChildNodes['grnti'].Text;
end;

function TXMLTitleinfoType.Get_Author: IXMLAuthorTypeList;
begin
  Result := FAuthor;
end;

function TXMLTitleinfoType.Get_Bbk: WideString;
begin
   Result := ChildNodes['bbk'].Text;
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

procedure TXMLTitleinfoType.Set_Author(Value: IXMLAuthorTypeList);
begin
  FAuthor := Value;
end;

procedure TXMLTitleinfoType.Set_Bbk(Value: WideString);
begin
  ChildNodes['bbk'].NodeValue := Value;
end;

procedure TXMLTitleinfoType.Set_Grnti(Value: WideString);
begin
  ChildNodes['grnti'].NodeValue := Value;
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

procedure TXMLTitleinfoType.Set_Translator(Value: IXMLAuthorTypeList);
begin
  FTranslator := Value;
end;

procedure TXMLTitleinfoType.Set_Udk(Value: WideString);
begin
  ChildNodes['udk'].NodeValue := Value;
end;

function TXMLTitleinfoType.Get_Translator: IXMLAuthorTypeList;
begin
  Result := FTranslator;
end;

function TXMLTitleinfoType.Get_Udk: WideString;
begin
   Result := ChildNodes['udk'].Text;
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
  RegisterChildNode('subtitle', TXMLPType);
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

function TXMLAnnotationType.Get_P: IXMLPTypeList;
begin
  Result := FP;
end;

function TXMLAnnotationType.Get_Subtitle: IXMLPType;
begin
  Result := ChildNodes['subtitle'] as IXMLPType;
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
begin
  Result := AttributeNodes['number'].NodeValue;
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

procedure TXMLDocumentinfo.Set_Author(Value: IXMLAuthorTypeList);
begin
  FAuthor := Value;
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