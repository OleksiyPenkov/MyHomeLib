(* *****************************************************************************
  *
  * MyHomeLib
  *
  * Copyright (C) 2008-2023 Oleksiy Penkov (aka Koreec)
  *
  * Authors Oleksiy Penkov   oleksiy.penkov@gmail.com
  *         Nick Rymanov     nrymanov@gmail.com
  * Created                  20.08.2008
  * Description              
  *
  * $Id: frm_statistic.pas 840 2010-10-06 07:37:58Z nrymanov@gmail.com $
  *
  * History
  *
  ****************************************************************************** *)

unit frm_statistic;

interface

uses
  Classes,
  Controls,
  Forms,
  ComCtrls,
  StdCtrls,
  unit_Interfaces;

type
  TfrmStat = class(TForm)
    btnClose: TButton;
    lvInfo: TListView;

  public
    procedure LoadCollectionInfo(const Collection: IBookCollection);
  end;

var
  frmStat: TfrmStat;

implementation

uses
  Variants,
  SysUtils,
  unit_Consts,
  unit_Helpers;

resourcestring
  rstrUnknown = 'unknown';

{$R *.dfm}

procedure TfrmStat.LoadCollectionInfo(const Collection: IBookCollection);
var
  vVersion: Variant;
  DataVersion: string;
  AuthorsCount: Integer;
  BooksCount: Integer;
  SeriesCount: Integer;
begin
  Assert(Assigned(Collection));

  Collection.GetStatistics(AuthorsCount, BooksCount, SeriesCount);

  vVersion := Collection.GetProperty(PROP_DATAVERSION);
  if VarIsEmpty(vVersion) then
    DataVersion := rstrUnknown
  else
    DataVersion := IntToStr(vVersion);

  //
  // Заполним данные
  //
  lvInfo.Items[0].SubItems[0] := Collection.GetProperty(PROP_DISPLAYNAME);
  lvInfo.Items[1].SubItems[0] := DateToStr(Collection.GetProperty(PROP_CREATIONDATE));
  lvInfo.Items[2].SubItems[0] := DataVersion;
  lvInfo.Items[3].SubItems[0] := Collection.GetProperty(PROP_NOTES);

  lvInfo.Items[4].SubItems[0] := IntToStr(AuthorsCount);
  lvInfo.Items[5].SubItems[0] := IntToStr(BooksCount);
  lvInfo.Items[6].SubItems[0] := IntToStr(SeriesCount);

  lvInfo.AutosizeColumn(0);
  lvInfo.AutosizeColumn(1);
end;

end.
