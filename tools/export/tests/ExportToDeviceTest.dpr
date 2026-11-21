program ExportToDeviceTest;

{$APPTYPE CONSOLE}
{$R '..\..\..\Program\MyhomeLib.dres'}

uses
  System.SysUtils,
  System.Classes,
  System.IOUtils,
  System.StrUtils,
  Vcl.Forms,
  Xml.XMLDoc,
  Xml.XMLIntf,
  fictionbook_21,
  dm_user,
  unit_Settings,
  unit_Consts,
  unit_Globals,
  unit_Interfaces,
  unit_MHLArchiveHelpers,
  unit_ExportToDeviceThread;

procedure Require(Condition: Boolean; const Message: string);
begin
  if not Condition then
    raise Exception.Create(Message);
end;

function CountOccurrences(const SubText, Text: string): Integer;
var
  Offset: Integer;
begin
  Result := 0;
  Offset := 1;
  while True do
  begin
    Offset := PosEx(SubText, Text, Offset);
    if Offset = 0 then
      Break;
    Inc(Result);
    Inc(Offset, Length(SubText));
  end;
end;

function SampleFb2Xml(const BookTitle, BodyParagraph: string): string;
begin
  Result :=
    '<?xml version="1.0" encoding="utf-8"?>' + #10 +
    '<FictionBook xmlns="http://www.gribuser.ru/xml/fictionbook/2.0">' + #10 +
    '  <description>' + #10 +
    '    <title-info>' + #10 +
    '      <genre>sf</genre>' + #10 +
    '      <author><first-name>Іван</first-name><last-name>Франко</last-name></author>' + #10 +
    '      <book-title>' + BookTitle + '</book-title>' + #10 +
    '      <lang>uk</lang>' + #10 +
    '    </title-info>' + #10 +
    '  </description>' + #10 +
    '  <body>' + #10 +
    '    <section>' + #10 +
    '      <p>' + BodyParagraph + '</p>' + #10 +
    '    </section>' + #10 +
    '  </body>' + #10 +
    '</FictionBook>';
end;

function NewCollection(const Name: string): Integer;
var
  Root: string;
begin
  Root := IncludeTrailingPathDelimiter(Settings.AppPath + Name);
  ForceDirectories(Root);
  Result := SystemDB.CreateCollection(Name, Root, Name + '.hlc2',
    CT_PRIVATE_FB, Settings.AppPath + 'genres_fb2.glst');
end;

procedure RunExportToFolder(const BookKey: TBookKey; const DestDir: string; Mode: TExportMode);
var
  Worker: TExportToDeviceThread;
  IdList: TBookIdList;
begin
  ForceDirectories(DestDir);
  SetLength(IdList, 1);
  IdList[0].BookKey := BookKey;
  Worker := TExportToDeviceThread.Create;
  try
    Worker.DeviceDir := DestDir;
    Worker.BookIdList := IdList;
    Worker.ExportMode := Mode;
    Worker.ExtractOnly := False;
    Worker.UseMTP := False;
    Worker.Start;
    Worker.WaitFor;
    if Assigned(Worker.FatalException) then
      raise Exception.Create(Exception(Worker.FatalException).Message);
  finally
    Worker.Free;
  end;
end;

procedure AssertSingleValidFb2(const Content, ExpectedTitle, ExpectedParagraph: string; const Context: string);
var
  Doc: IXMLDocument;
  Book: IXMLFictionBook;
begin
  Require(CountOccurrences('<FictionBook', Content) = 1,
    Context + ': expected 1 <FictionBook> root element, got ' +
    IntToStr(CountOccurrences('<FictionBook', Content)));
  Require(CountOccurrences('</FictionBook>', Content) = 1,
    Context + ': expected 1 </FictionBook> closing tag, got ' +
    IntToStr(CountOccurrences('</FictionBook>', Content)));
  Require(CountOccurrences(ExpectedParagraph, Content) = 1,
    Context + ': expected body paragraph once, got ' +
    IntToStr(CountOccurrences(ExpectedParagraph, Content)));

  Doc := TXMLDocument.Create(nil);
  Doc.LoadFromXML(Content);
  Doc.Active := True;
  Book := GetFictionBook(Doc);
  Require( string(Book.Description.Titleinfo.Booktitle.Text) = ExpectedTitle,
    Context + ': expected <book-title>="' + ExpectedTitle + '", got "' +
    string(Book.Description.Titleinfo.Booktitle.Text) + '"');
end;

procedure TestArchivedFb2ExportOverwritesInfoWithoutDoubling;
var
  CollectionID, BookID: Integer;
  Collection: IBookCollection;
  Root, DestDir, ExportedFile, ZipPath, Content: string;
  Zip: TMHLZip;
  Payload: TStringStream;
  Extracted: TMemoryStream;
  Bytes: TBytes;
  R: TBookRecord;
begin
  CollectionID := NewCollection('archived-fb2-export');
  Collection := SystemDB.GetCollection(CollectionID);
  Root := Collection.CollectionRoot;

  Zip := TMHLZip.Create(TPath.Combine(Root, 'bundle.zip'), False);
  try
    Payload := TStringStream.Create(
      SampleFb2Xml('Original Archive Title', 'Unique archive paragraph text.'),
      TEncoding.UTF8);
    try
      Zip.AddFromStream('book1.fb2', Payload);
    finally
      Payload.Free;
    end;
  finally
    Zip.Free;
  end;

  R.Clear;
  R.Title := 'Catalog Archive Title';
  R.FileName := 'book1';
  R.FileExt := '.fb2';
  R.Folder := 'bundle.zip';
  R.InsideNo := 0;
  R.LibID := '1';
  R.Lang := 'uk';
  R.Date := Now;
  TAuthorsHelper.Add(R.Authors, 'Франко', 'Іван', '');
  TGenresHelper.Add(R.Genres, 'sf', 'Наукова фантастика', 'sf');
  Include(R.BookProps, bpIsLocal);
  BookID := Collection.InsertBook(R, False, False);
  Require(BookID > 0, 'Failed to insert archived FB2 book');
  Collection := nil;

  Settings.OverwriteFB2Info := True;
  Settings.BookHeaderTemplate := '%t';
  Settings.FolderTemplate := '';
  Settings.FileNameTemplate := '%t';

  DestDir := Settings.AppPath + 'out-archived-fb2';
  RunExportToFolder(CreateBookKey(BookID, CollectionID), DestDir, emFB2);

  ExportedFile := TPath.Combine(DestDir, 'Catalog Archive Title.fb2');
  Require(TFile.Exists(ExportedFile), 'Exported archived FB2 file missing: ' + ExportedFile);
  Content := TFile.ReadAllText(ExportedFile, TEncoding.UTF8);
  AssertSingleValidFb2(Content, 'Catalog Archive Title', 'Unique archive paragraph text.', 'Archived emFB2');

  DestDir := Settings.AppPath + 'out-archived-fb2zip';
  RunExportToFolder(CreateBookKey(BookID, CollectionID), DestDir, emFB2Zip);

  ZipPath := TPath.Combine(DestDir, 'Catalog Archive Title.fb2.zip');
  Require(TFile.Exists(ZipPath), 'Exported archived FB2.ZIP file missing: ' + ZipPath);
  Zip := TMHLZip.Create(ZipPath, True);
  try
    Require(Zip.FileCount = 1, 'Expected 1 entry in exported FB2.ZIP');
    Extracted := Zip.ExtractToStream(0);
    try
      Extracted.Position := 0;
      SetLength(Bytes, Extracted.Size);
      if Extracted.Size > 0 then
        Extracted.ReadBuffer(Bytes[0], Length(Bytes));
      Content := TEncoding.UTF8.GetString(Bytes);
    finally
      Extracted.Free;
    end;
  finally
    Zip.Free;
  end;
  AssertSingleValidFb2(Content, 'Catalog Archive Title', 'Unique archive paragraph text.', 'Archived emFB2Zip');

  Writeln('PASS archived_fb2_export_overwrites_info_without_doubling');
end;

procedure TestLooseFb2ExportOverwritesInfoWithoutMutatingSource;
var
  CollectionID, BookID: Integer;
  Collection: IBookCollection;
  Root, SourceFile, DestDir, ExportedFile, Content, SourceContent: string;
  R: TBookRecord;
begin
  CollectionID := NewCollection('loose-fb2-export');
  Collection := SystemDB.GetCollection(CollectionID);
  Root := Collection.CollectionRoot;

  SourceFile := TPath.Combine(Root, 'loose1.fb2');
  TFile.WriteAllText(SourceFile,
    SampleFb2Xml('Original Loose Title', 'Unique loose paragraph text.'),
    TEncoding.UTF8);

  R.Clear;
  R.Title := 'Catalog Loose Title';
  R.FileName := 'loose1';
  R.FileExt := '.fb2';
  R.Folder := '';
  R.InsideNo := 0;
  R.LibID := '2';
  R.Lang := 'uk';
  R.Date := Now;
  TAuthorsHelper.Add(R.Authors, 'Франко', 'Іван', '');
  TGenresHelper.Add(R.Genres, 'sf', 'Наукова фантастика', 'sf');
  Include(R.BookProps, bpIsLocal);
  BookID := Collection.InsertBook(R, False, False);
  Require(BookID > 0, 'Failed to insert loose FB2 book');
  Collection := nil;

  Settings.OverwriteFB2Info := True;
  Settings.BookHeaderTemplate := '%t';
  Settings.FolderTemplate := '';
  Settings.FileNameTemplate := '%t';

  DestDir := Settings.AppPath + 'out-loose-fb2';
  RunExportToFolder(CreateBookKey(BookID, CollectionID), DestDir, emFB2);

  ExportedFile := TPath.Combine(DestDir, 'Catalog Loose Title.fb2');
  Require(TFile.Exists(ExportedFile), 'Exported loose FB2 file missing: ' + ExportedFile);
  Content := TFile.ReadAllText(ExportedFile, TEncoding.UTF8);
  AssertSingleValidFb2(Content, 'Catalog Loose Title', 'Unique loose paragraph text.', 'Loose emFB2');

  SourceContent := TFile.ReadAllText(SourceFile, TEncoding.UTF8);
  AssertSingleValidFb2(SourceContent, 'Original Loose Title', 'Unique loose paragraph text.', 'Loose source file');

  Writeln('PASS loose_fb2_export_overwrites_info_without_mutating_source');
end;

begin
  try
    Application.Initialize;
    DMUser := TDMUser.Create(nil);
    try
      DMUser.Init;
      TestArchivedFb2ExportOverwritesInfoWithoutDoubling;
      TestLooseFb2ExportOverwritesInfoWithoutMutatingSource;
    finally
      DMUser.Free;
      DMUser := nil;
    end;
  except
    on E: Exception do
    begin
      Writeln('FAIL ', E.ClassName, ': ', E.Message);
      Halt(1);
    end;
  end;
end.
