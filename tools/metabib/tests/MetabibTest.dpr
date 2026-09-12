program MetabibTest;

{$APPTYPE CONSOLE}

// Test harness for unit_MetabibReader. Not shipped, not in any dproj.
//
// Usage:  MetabibTest.exe <dataset.jsonl> <report.json>
//
// Reads every record through the real public API -- Create/ReadNext, the same
// path unit_ImportMetabibThread takes -- and writes a UTF-8 JSON report.
//
// The report goes to a FILE rather than stdout because the values under test
// are Cyrillic and console output would go through the console code page.

uses
  System.SysUtils,
  System.IOUtils,
  System.JSON,
  unit_MetabibReader;

var
  Reader: TMetabibReader;
  Book: TMetabibBook;
  Res: TMetabibReadResult;
  Report: TJSONObject;
  Books: TJSONArray;
  Obj: TJSONObject;
  Bad: Integer;
begin
  if ParamCount < 2 then
  begin
    Writeln('usage: MetabibTest.exe <dataset.jsonl> <report.json>');
    Halt(2);
  end;

  Report := TJSONObject.Create;
  try
    Books := TJSONArray.Create;
    Bad := 0;
    try
      Reader := TMetabibReader.Create(ParamStr(1));
      try
        Report.AddPair('library', Reader.LibraryName);
        repeat
          Res := Reader.ReadNext(Book);
          if Res = mrBadLine then
            Inc(Bad);
          if Res <> mrOk then
            Continue;

          Obj := TJSONObject.Create;
          Obj.AddPair('book_id', TJSONNumber.Create(Book.BookID));
          Obj.AddPair('title', Book.Title);
          Obj.AddPair('lang', Book.Lang);
          Obj.AddPair('annotation', Book.Annotation);
          Obj.AddPair('keywords', Book.Keywords);
          Obj.AddPair('publisher', Book.Publisher);
          Obj.AddPair('isbn', Book.ISBN);
          Obj.AddPair('pub_year', TJSONNumber.Create(Book.PubYear));
          Obj.AddPair('deleted', TJSONBool.Create(Book.Deleted));
          Books.AddElement(Obj);
        until Res = mrEof;
      finally
        Reader.Free;
      end;
    except
      on E: Exception do
        Report.AddPair('error', E.ClassName + ': ' + E.Message);
    end;
    Report.AddPair('books', Books);
    Report.AddPair('bad_lines', TJSONNumber.Create(Bad));

    TFile.WriteAllText(ParamStr(2), Report.ToJSON, TEncoding.UTF8);
  finally
    Report.Free;
  end;
end.
