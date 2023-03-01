(* *****************************************************************************
  *
  * MyHomeLib
  *
  * Copyright (C) 2008-2013 Aleksey Penkov
  *
  * Author(s)           Oleksiy Penkov  oleksiy.penkov@gmail.com
  * Created             12.02.2010
  * Description
  *
  * $Id: unit_TreeUtils.pas 1128 2013-06-27 08:07:15Z koreec $
  *
  * History
  * NickR 15.02.2010    Код переформатирован
  *
  ****************************************************************************** *)

unit unit_TreeUtils;

interface

uses
  VirtualTrees,
  BookTreeView,
  SysUtils,
  unit_Globals,
  unit_Consts,
  unit_Interfaces;

type
  TSelectionList = array of PVirtualNode;

function FindParentInTree(Tree: TVirtualStringTree; const Folder: string): PVirtualNode;
function FindSeriesInTree(Tree: TBookTree; Parent: PVirtualNode; SeriesID: Integer): PVirtualNode;
procedure GetSelections(Tree: TBookTree; out List: TSelectionList);

procedure FillAuthorTree(Tree: TVirtualStringTree; const AuthorIterator: IAuthorIterator; SelectID: Integer = MHL_INVALID_ID);
procedure FillSeriesTree(Tree: TVirtualStringTree; const SeriesIterator: ISeriesIterator; SelectID: Integer = MHL_INVALID_ID);
procedure FillGenresTree(Tree: TVirtualStringTree; const GenreIterator: IGenreIterator; FillFB2: Boolean = False; const SelectCode: string = '');
procedure FillGroupsList(Tree: TVirtualStringTree; const GroupIterator: IGroupIterator; SelectID: Integer = MHL_INVALID_ID);

function Export2HTML(const Tag: integer; const Path: string; var Tree: TBookTree): string;

implementation

uses
  unit_UserData,
  unit_Settings,
  Generics.Collections,
  System.Classes;

//  ============= Exports =====================================================
function Export2HTML;
const
  HTMLHead =
    '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0//EN">' + CRLF +
    '<html>' + CRLF +
    '<head>' + CRLF +
    '  <meta http-equiv="Content-Type" content="text/html; charset=utf-8">' + CRLF +
    '  <title>MyHomeLib HTML</title>' + CRLF +
    '</head>' + CRLF +
    '<body>' + CRLF;
  HTMLFoot =
    '</body>' + CRLF +
    '</html>' + CRLF;

  Ext: array [351 .. 353] of string = ('html', 'txt', 'rtf');
var
  FS: TFileStream;
  Str: AnsiString;
  Data: Pointer;
begin
  Result := (Path + 'book_list.' + Ext[Tag]);

  FS := TFileStream.Create(Result, fmCreate);
  try
    case Tag of
      351:
        Str := HTMLHead + Tree.ContentToHTML(tstAll) + HTMLFoot;
      352:
        Str := AnsiString(Tree.ContentToText(tstAll, Chr(9)));
      353:
        Str := Tree.ContentToRTF(tstAll);
    end;
    Data := PChar(Str);
    FS.WriteBuffer(Data^, Length(Str));
  finally
    FreeAndNil(FS);
  end;
end;


// ============================================================================
procedure GetSelections(Tree: TBookTree; out List: TSelectionList);
var
  Node: PVirtualNode;
  i: Integer;
begin
  SetLength(List, Tree.SelectedCount);
  Node := Tree.GetFirstSelected;
  for i := 0 to Tree.SelectedCount - 1 do
  begin
    List[i] := Node;
    Node := Tree.GetNextSelected(Node);
  end;
end;

// ============================================================================
function FindParentInTree(Tree: TVirtualStringTree; const Folder: string): PVirtualNode;
var
  Node: PVirtualNode;
  Data: PFileData;
begin
  Result := nil;
  Node := Tree.GetFirst;
  Data := Tree.GetNodeData(Node);
  if Data = nil then
    Exit;

  while Node <> nil do
  begin
    Data := Tree.GetNodeData(Node);
    if (Data.DataType = dtFolder) and (Data.Folder = Folder) then
    begin
      Result := Node;
      Break;
    end;
    Node := Tree.GetNext(Node);
  end;
end;

// ============================================================================
function FindSeriesInTree(Tree: TBookTree; Parent: PVirtualNode; SeriesID: Integer): PVirtualNode;
var
  Node: PVirtualNode;
  Data: PBookRecord;
begin
  Result := nil;
  if Assigned(Parent) then
    Node := Parent.FirstChild
  else
    Node := Tree.GetFirst;

  while Assigned(Node) do
  begin
    Data := Tree.GetNodeData(Node);
    Assert(Assigned(Data));
    if (Data^.nodeType = ntSeriesInfo) and (Data.SeriesID = SeriesID) then
    begin
      Result := Node;
      Break;
    end;
    Node := Tree.GetNextSibling(Node);
  end;
end;

// ============================================================================
procedure SafeSelectNode(Tree: TVirtualStringTree; Node: PVirtualNode);
begin
  Assert(Assigned(Tree));

  if not Assigned(Node) then
    Node := Tree.GetFirst;

  if Assigned(Node) then
  begin
    Tree.Selected[Node] := True;
    Tree.FocusedNode := Node;
    Tree.TopNode := Node;
    //Tree.FullyVisible[Node] := True;
    Tree.ScrollIntoView(Node, True);
  end;
end;

// ============================================================================
procedure FillAuthorTree(Tree: TVirtualStringTree; const AuthorIterator: IAuthorIterator; SelectID: Integer = MHL_INVALID_ID);
var
  Node: PVirtualNode;
  NodeData: PAuthorData;
  AuthorData: TAuthorData;
  SelectedNode: PVirtualNode;
begin
  Tree.NodeDataSize := SizeOf(TAuthorData);

  Tree.BeginSynch;
  try
    Tree.BeginUpdate;
    try
      Tree.Clear;
      SelectedNode := nil;

      while AuthorIterator.Next(AuthorData) do
      begin
        Node := Tree.AddChild(nil);
        NodeData := Tree.GetNodeData(Node);

        Initialize(NodeData^);
        NodeData^ := AuthorData;

        if NodeData^.AuthorID = SelectID then
          SelectedNode := Node;
      end;

      SafeSelectNode(Tree, SelectedNode);
    finally
      Tree.EndUpdate;
    end;
  finally
    Tree.EndSynch;
  end;
end;

// ============================================================================
procedure FillSeriesTree(Tree: TVirtualStringTree; const SeriesIterator: ISeriesIterator; SelectID: Integer = MHL_INVALID_ID);
var
  Node: PVirtualNode;
  Data: PSeriesData;
  SelectedNode: PVirtualNode;
  SeriesData: TSeriesData;
begin
  Tree.NodeDataSize := SizeOf(TSeriesData);

  Tree.BeginSynch;
  try
    Tree.BeginUpdate;
    try
      Tree.Clear;
      SelectedNode := nil;

      while SeriesIterator.Next(SeriesData) do
      begin
        Node := Tree.AddChild(nil);
        Data := Tree.GetNodeData(Node);

        Initialize(Data^);
        Data^ := SeriesData;

        if Data^.SeriesID = SelectID then
          SelectedNode := Node;
      end;

      SafeSelectNode(Tree, SelectedNode);
    finally
      Tree.EndUpdate;
    end;
  finally
    Tree.EndSynch;
  end;
end;

// ============================================================================
procedure FillGenresTree(Tree: TVirtualStringTree; const GenreIterator: IGenreIterator; FillFB2: Boolean = False; const SelectCode: string = '');
var
  GenreNode: PVirtualNode;
  Data: PGenreData;
  Genre: TGenreData;
  Nodes: TDictionary<string, PVirtualNode>;
  ParentNode: PVirtualNode;
  SelectedNode: PVirtualNode;
begin
  Tree.NodeDataSize := SizeOf(TGenreData);

  Nodes := TDictionary<string, PVirtualNode>.Create;
  try
    Tree.BeginSynch;
    try
      Tree.BeginUpdate;
      try
        Tree.Clear;
        SelectedNode := nil;

        while GenreIterator.Next(Genre) do
        begin
          ParentNode := nil;
          if (Genre.ParentCode <> '0') and Nodes.ContainsKey(Genre.ParentCode) then
            ParentNode := Nodes[Genre.ParentCode];

          GenreNode := Tree.AddChild(ParentNode);
          Data := Tree.GetNodeData(GenreNode);

          Initialize(Data^);
          Data^ := Genre;
          if not FillFB2 then
            Data^.FB2GenreCode := '';

          Nodes.AddOrSetValue(Data^.GenreCode, GenreNode);

          if Data^.GenreCode = SelectCode then
          begin
            SelectedNode := GenreNode;
          end;
        end;

        SafeSelectNode(Tree, SelectedNode);
      finally
        Tree.EndUpdate;
      end;
    finally
      Tree.EndSynch;
    end;
  finally
    Nodes.Free;
  end;
end;

// ============================================================================
procedure FillGroupsList(Tree: TVirtualStringTree; const GroupIterator: IGroupIterator; SelectID: Integer = MHL_INVALID_ID);
var
  Node: PVirtualNode;
  Data: PGroupData;
  SelectedNode: PVirtualNode;
  Group: TGroupData;
begin
  Tree.BeginSynch;
  try
    Tree.BeginUpdate;
    try
      Tree.Clear;
      SelectedNode := nil;

      while GroupIterator.Next(Group) do
      begin
        Node := Tree.AddChild(nil);
        Data := Tree.GetNodeData(Node);

        Initialize(Data^);
        Data^ := Group;

        if Data^.GroupID = SelectID then
          SelectedNode := Node;
      end;

      SafeSelectNode(Tree, SelectedNode);
    finally
      Tree.EndUpdate;
    end;
  finally
    Tree.EndSynch;
  end;
end;


end.
