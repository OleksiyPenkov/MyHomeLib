unit unit_MetabibWriter;

interface

uses
  System.Classes, System.SysUtils, unit_Globals, unit_MetabibReader;

type
  TMetabibExportArchive = record
    ID, Name: string;
    Ordinal, Entries, FB2Entries: Integer;
  end;

  TMetabibExportLocation = record
    ArchiveID, EntryName: string;
    EntryIndex, ExportBookID: Integer;
    UncompressedSize: Int64;
  end;

  TMetabibWriter = class
  public
    class procedure WriteRecord(Stream: TStream; const R: TBookRecord;
      const Genres: TArray<TMetabibGenre>; const Location: TMetabibExportLocation;
      const LibraryName, SourceID: string); static;
    class procedure WriteDataset(Stream, RecordSpool: TStream;
      const DatasetID, LibraryName, GeneratorVersion: string;
      CreatedUTC: TDateTime; RecordCount: Integer;
      const Archives: TArray<TMetabibExportArchive>); static;
  end;

implementation

uses
  System.JSON, System.DateUtils;

function One(Value: TJSONValue): TJSONArray;
begin
  Result := TJSONArray.Create;
  Result.AddElement(Value);
end;

function Claim(Value: TJSONValue): TJSONArray;
begin
  Result := TJSONArray.Create;
  Result.AddElement(TJSONObject.Create.AddPair('observation', 'db').AddPair('value', Value));
end;

procedure AddText(Obj: TJSONObject; const Name, Value: string);
begin
  if Value <> '' then
    Obj.AddPair(Name, Claim(TJSONString.Create(Value)));
end;

procedure WriteLine(Stream: TStream; Obj: TJSONObject);
const
  LF: Byte = 10;
var
  Bytes: TBytes;
begin
  Bytes := TEncoding.UTF8.GetBytes(Obj.ToJSON);
  if Length(Bytes) <> 0 then
    Stream.WriteBuffer(Bytes[0], Length(Bytes));
  Stream.WriteBuffer(LF, 1);
end;

class procedure TMetabibWriter.WriteRecord(Stream: TStream; const R: TBookRecord;
  const Genres: TArray<TMetabibGenre>; const Location: TMetabibExportLocation;
  const LibraryName, SourceID: string);
var
  Root, Bib, Pub, Cat, Item, Locator: TJSONObject;
  Persons, GenreValues, Observations: TJSONArray;
  Author: TAuthorData;
  Genre: TMetabibGenre;
begin
  Root := TJSONObject.Create;
  try
    Root.AddPair('schema', 'metabib.dataset_record/1');
    Locator := TJSONObject.Create.AddPair('kind', 'archive_entry')
      .AddPair('source', Location.ArchiveID)
      .AddPair('index', TJSONNumber.Create(Location.EntryIndex))
      .AddPair('book_id', TJSONNumber.Create(Location.ExportBookID));
    Root.AddPair('record', TJSONObject.Create.AddPair('library', LibraryName).AddPair('locator', Locator));
    Item := TJSONObject.Create.AddPair('archive', Location.ArchiveID)
      .AddPair('entry', Location.EntryName)
      .AddPair('index', TJSONNumber.Create(Location.EntryIndex))
      .AddPair('uncompressed_size', TJSONNumber.Create(Location.UncompressedSize));
    Root.AddPair('artifacts', One(TJSONObject.Create
      .AddPair('name', Location.EntryName).AddPair('occurrences', One(Item))));
    Observations := TJSONArray.Create;
    Root.AddPair('observations', Observations);
    Observations.AddElement(TJSONObject.Create.AddPair('id', 'db').AddPair('source', SourceID)
      .AddPair('kind', 'database_book').AddPair('status', 'present'));
    Observations.AddElement(TJSONObject.Create.AddPair('id', 'archive').AddPair('source', Location.ArchiveID)
      .AddPair('kind', 'archive_entry').AddPair('status', 'present')
      .AddPair('locator', TJSONObject.Create.AddPair('entry', Location.EntryName)
        .AddPair('index', TJSONNumber.Create(Location.EntryIndex))));
    if R.LibID <> '' then
      Root.AddPair('identities', TJSONObject.Create.AddPair('catalog', One(
        TJSONObject.Create.AddPair('scheme', 'myhomelib.libid')
          .AddPair('value', R.LibID).AddPair('observation', 'db').AddPair('basis', 'source_catalog'))));
    Bib := TJSONObject.Create;
    Pub := TJSONObject.Create;
    Cat := TJSONObject.Create;
    Root.AddPair('claims', TJSONObject.Create.AddPair('bibliographic', Bib)
      .AddPair('publication', Pub).AddPair('catalog', Cat));
    AddText(Bib, 'title', R.Title);
    AddText(Bib, 'language', R.Lang);
    AddText(Bib, 'annotation', R.Annotation);
    AddText(Bib, 'keywords', R.KeyWords);
    Persons := TJSONArray.Create;
    Bib.AddPair('authors', Claim(Persons));
    for Author in R.Authors do
      Persons.AddElement(TJSONObject.Create.AddPair('last_name', Author.LastName)
        .AddPair('first_name', Author.FirstName).AddPair('middle_name', Author.MiddleName));
    if R.Translators <> '' then
      Bib.AddPair('translators', One(TJSONObject.Create
        .AddPair('observation', 'db').AddPair('value', R.Translators)
        .AddPair('raw', TJSONObject.Create.AddPair('format', 'myhomelib.translators-display/1'))));
    GenreValues := TJSONArray.Create;
    Bib.AddPair('genres', Claim(GenreValues));
    for Genre in Genres do
    begin
      Item := TJSONObject.Create.AddPair('code', Genre.Code)
        .AddPair('description', Genre.Description).AddPair('meta', Genre.Category);
      GenreValues.AddElement(Item);
      if Genre.TranslatedCode <> '' then
        Item.AddPair('translated_code', Genre.TranslatedCode);
    end;
    if R.Series <> '' then
      Bib.AddPair('sequences', Claim(One(TJSONObject.Create
        .AddPair('name', R.Series).AddPair('number', TJSONObject.Create
          .AddPair('value', TJSONNumber.Create(R.SeqNumber))))));
    AddText(Pub, 'publisher', R.Publisher);
    AddText(Pub, 'city', R.City);
    AddText(Pub, 'isbn', R.ISBN);
    if R.PubYear <> 0 then
      Pub.AddPair('year', Claim(TJSONNumber.Create(R.PubYear)));
    Cat.AddPair('rating', Claim(TJSONObject.Create.AddPair('average', TJSONNumber.Create(R.LibRate))));
    Item := TJSONObject.Create;
    if bpIsDeleted in R.BookProps then
      Item.AddPair('state', 'deleted')
    else
      Item.AddPair('state', 'active');
    Cat.AddPair('deleted', Claim(Item));
    if R.Date <> 0 then
      AddText(Cat, 'modified', DateToISO8601(R.Date, True));
    WriteLine(Stream, Root);
  finally
    Root.Free;
  end;
end;

class procedure TMetabibWriter.WriteDataset(Stream, RecordSpool: TStream;
  const DatasetID, LibraryName, GeneratorVersion: string; CreatedUTC: TDateTime;
  RecordCount: Integer; const Archives: TArray<TMetabibExportArchive>);
var
  Header: TJSONObject;
  Values: TJSONArray;
  Archive: TMetabibExportArchive;
begin
  Header := TJSONObject.Create;
  try
    Header.AddPair('schema', 'metabib.dataset/1').AddPair('id', DatasetID)
      .AddPair('record_schema', 'metabib.dataset_record/1').AddPair('library', LibraryName)
      .AddPair('created', DateToISO8601(CreatedUTC, True))
      .AddPair('records', TJSONNumber.Create(RecordCount))
      .AddPair('generator', TJSONObject.Create.AddPair('name', 'MyHomeLib').AddPair('version', GeneratorVersion))
      .AddPair('normalization', TJSONObject.Create.AddPair('model', 'myhomelib.catalog-snapshot/1'))
      .AddPair('ordering', TJSONObject.Create.AddPair('mode', 'archive_entry').AddPair('direction', 'ascending'))
      .AddPair('processing', TJSONObject.Create.AddPair('parse_fb2', TJSONBool.Create(False))
        .AddPair('archive_content_checksum', TJSONObject.Create.AddPair('enabled', TJSONBool.Create(False))));
    Values := TJSONArray.Create;
    Header.AddPair('archives', Values);
    for Archive in Archives do
      Values.AddElement(TJSONObject.Create.AddPair('id', Archive.ID)
        .AddPair('ordinal', TJSONNumber.Create(Archive.Ordinal)).AddPair('name', Archive.Name)
        .AddPair('entries', TJSONNumber.Create(Archive.Entries))
        .AddPair('fb2_entries', TJSONNumber.Create(Archive.FB2Entries)));
    WriteLine(Stream, Header);
    RecordSpool.Position := 0;
    Stream.CopyFrom(RecordSpool, RecordSpool.Size);
  finally
    Header.Free;
  end;
end;

end.
