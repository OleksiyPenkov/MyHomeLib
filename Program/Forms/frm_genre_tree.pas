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
  * $Id: frm_genre_tree.pas 859 2010-10-11 08:46:46Z eg_ $
  *
  * History
  *
  ****************************************************************************** *)

unit frm_genre_tree;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, VirtualTrees, ExtCtrls, unit_globals, StdCtrls;

type
  TfrmGenreTree = class(TForm)
    tvGenresTree: TVirtualStringTree;
    pnButtons: TPanel;
    btnOk: TButton;
    btnCancel: TButton;
    procedure tvGenresTreeGetNodeDataSize(Sender: TBaseVirtualTree; var NodeDataSize: Integer);
    procedure tvGenresTreeGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType; var CellText: String);
    procedure tvGenresTreeFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);

  public
    procedure SelectGenres(const Genres: TBookGenres);

    procedure GetSelectedGenres(var R: TBookRecord); overload;
    procedure GetSelectedGenres(var Genres: TBookGenres); overload;
  end;

var
  frmGenreTree: TfrmGenreTree;

implementation

uses
  unit_Consts;

{$R *.dfm}

procedure TfrmGenreTree.SelectGenres(const Genres: TBookGenres);
var
  Genre: TGenreData;
  Node: PVirtualNode;
  Data: PGenreData;
begin
  for Genre in Genres do
  begin
    Node := tvGenresTree.GetFirst;
    while Assigned(Node) do
    begin
      Data := tvGenresTree.GetNodeData(Node);
      if Data^.GenreCode = Genre.GenreCode then
      begin
        tvGenresTree.Selected[Node] := True;
        tvGenresTree.Expanded[Node.Parent] := True;
        Break;
      end;
      Node := tvGenresTree.GetNext(Node);
    end;
  end;
end;

procedure TfrmGenreTree.GetSelectedGenres(var Genres: TBookGenres);
var
  Node: PVirtualNode;
  Data: PGenreData;
begin
  SetLength(Genres, 0);

  Node := tvGenresTree.GetFirstSelected;
  while Assigned(Node) do
  begin
    Data := tvGenresTree.GetNodeData(Node);
    if Assigned(Data) then
      TGenresHelper.Add(Genres, Data^.GenreCode, Data^.GenreAlias, Data^.FB2GenreCode);
    Node := tvGenresTree.GetNextSelected(Node);
  end;
end;

procedure TfrmGenreTree.GetSelectedGenres(var R: TBookRecord);
begin
  R.ClearGenres;

  GetSelectedGenres(R.Genres);

  if R.GenreCount = 0 then
    TGenresHelper.Add(R.Genres, UNKNOWN_GENRE_CODE, '', '');
end;

procedure TfrmGenreTree.tvGenresTreeFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
var
  Data: PGenreData;
begin
  Data := tvGenresTree.GetNodeData(Node);
  if Assigned(Data) then
    Finalize(Data^);
end;

procedure TfrmGenreTree.tvGenresTreeGetNodeDataSize(Sender: TBaseVirtualTree; var NodeDataSize: Integer);
begin
  NodeDataSize := Sizeof(TGenreData);
end;

procedure TfrmGenreTree.tvGenresTreeGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex;
  TextType: TVSTTextType; var CellText: String);
var
  Data: PGenreData;
begin
  Data := tvGenresTree.GetNodeData(Node);
  CellText := Data^.GenreAlias;
end;

end.
