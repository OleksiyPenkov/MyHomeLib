(* *****************************************************************************
  *
  * MyHomeLib
  *
  * Copyright (C) 2008-2023 Oleksiy Penkov (aka Koreec)
  *
  * Author(s)           Aleksey Penkov
  *                     Nick Rymanov (nrymanov@gmail.com)
  * Created             15.04.2010
  * Description
  *
  * $Id: FBDAuthorTable.pas 1000 2011-05-15 02:22:52Z koreec $
  *
  * History
  *
  ****************************************************************************** *)

unit FBDAuthorTable;

interface

uses
  SysUtils,
  Classes,
  Controls,
  ExtCtrls,
  ComCtrls,
  StdCtrls,
  Forms,
  Buttons,
  Graphics,
  Mask;

type

  TAuthorRecord = record
    First, Last, Middle, Nick, Email, Homepage: string;
  end;

  TAuthorDataList = array of TAuthorRecord;

  TfrmEditAuthorFull = class(TForm)
    gbButtons: TPanel;
    btnSave: TButton;
    btnCancel: TButton;
    gbEdits: TPanel;
    edFamily: TEdit;
    Label1: TLabel;
    edName: TEdit;
    Label2: TLabel;
    edMiddle: TEdit;
    Label3: TLabel;
    edEmail: TEdit;
    Label4: TLabel;
    edHomepage: TEdit;
    Label5: TLabel;
    Separator: TBevel;
    edNick: TEdit;
    Label6: TLabel;
    procedure FormShow(Sender: TObject);
  private
    function GetAuthor: TAuthorRecord;
    procedure SetAuthor(const Value: TAuthorRecord);

  public
    property Author: TAuthorRecord read GetAuthor write SetAuthor;
  end;

  TFBDAuthorTable = class(TCustomPanel)
  private
    FList: TListView;
    FAdd: TButton;
    FChange: TButton;
    FDelete: TButton;
    FAddAuthorFromList: TButton;

    FReadOnly: Boolean;
    function GetActiveRecord: TAuthorRecord;
    procedure SetActiveRecord(const Value: TAuthorRecord);
    function GetList: TAuthorDataList;
    procedure SetList(List: TAuthorDataList);
    function GetAuthorsCount: integer;

    procedure OnSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
    procedure SetReadOnly(const Value: Boolean);

  protected
    procedure Add(Sender: TObject);
    procedure Delete(Sender: TObject);
    procedure Change(Sender: TObject);

    procedure UpdateButtons;

  public
    constructor Create(AOwner: TComponent); override;

    procedure AddAuthor(const Author: TAuthorRecord);
    procedure Clear;

    property Items: TAuthorDataList read GetList write SetList;
    property Count: Integer read GetAuthorsCount;
    property ActiveRecord: TAuthorRecord read GetActiveRecord write SetActiveRecord;
    property AddAuthorFromListButton: TButton read FAddAuthorFromList;

  published
    property Align;
    //property Alignment;
    property Anchors;
    property AutoSize;
    //property BevelEdges;
    //property BevelInner;
    //property BevelKind;
    //property BevelOuter default bvNone;
    //property BevelWidth;
    property BiDiMode;
    property BorderWidth;
    property BorderStyle;
    //property Caption;
    property Color;
    property Constraints;
    property Ctl3D;
    property UseDockManager default True;
    property DockSite;
    property DoubleBuffered;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property FullRepaint;
    property Font;
    property Locked;
    property Padding;
    property ParentBiDiMode;
    property ParentBackground;
    property ParentColor;
    property ParentCtl3D;
    property ParentDoubleBuffered;
    property ParentFont;
    property ParentShowHint;
    //property PopupMenu;
    //property ShowCaption;
    property ReadOnly: Boolean read FReadOnly write SetReadOnly default False;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Touch;

    //property VerticalAlignment;
    property Visible;
    property OnAlignInsertBefore;
    property OnAlignPosition;
    property OnCanResize;
    property OnClick;
    property OnConstrainedResize;
    property OnContextPopup;
    property OnDockDrop;
    property OnDockOver;
    //property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnGesture;
    property OnGetSiteInfo;
    property OnMouseActivate;
    property OnMouseDown;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnMouseMove;
    property OnMouseUp;
    property OnResize;
    property OnStartDock;
    property OnStartDrag;
    property OnUnDock;
  end;

resourcestring
  rstrLastName = 'Фамилия';
  rstrFirstName = 'Имя';
  rstrMiddleName = 'Отчество';
  rstrNickName = 'Nick';
  rstrEmail = 'Email';
  rstrHomepage = 'Homepage';
  rstrAdd = 'Добавить';
  rstrChange = 'Изменить';
  rstrDelete = 'Удалить';
  rstrAddFromList = 'Из списка';

implementation

{$R *.dfm}

uses
  Dialogs;

{ TFBDAuthorTable }

procedure TFBDAuthorTable.Add(Sender: TObject);
var
  InputForm: TfrmEditAuthorFull;
begin
  if ReadOnly then
    Exit;

  InputForm := TfrmEditAuthorFull.Create(Self);
  try
    if InputForm.ShowModal = mrOk then
    begin
      AddAuthor(InputForm.Author);
    end;
  finally
    InputForm.Free;
  end;
end;

procedure TFBDAuthorTable.AddAuthor(const Author: TAuthorRecord);
var
  Row: TListItem;
begin
  Row := FList.Items.Add;
  Row.Caption := Author.Last;
  Row.SubItems.Add(Author.First);
  Row.SubItems.Add(Author.Middle);
  Row.SubItems.Add(Author.Nick);
  Row.SubItems.Add(Author.Email);
  Row.SubItems.Add(Author.Homepage);
  //Row.Focused := True;
  FList.Selected := Row;

  UpdateButtons;
end;

procedure TFBDAuthorTable.Change(Sender: TObject);
var
  InputForm: TfrmEditAuthorFull;
begin
  if not Assigned(FList.Selected) or ReadOnly then
    Exit;

  InputForm := TfrmEditAuthorFull.Create(Self);
  try
    InputForm.Author := ActiveRecord;
    if InputForm.ShowModal = mrOk then
    begin
      ActiveRecord := InputForm.Author;
    end;
  finally
    InputForm.Free;
  end;
end;

procedure TFBDAuthorTable.Clear;
begin
  FList.Items.Clear;

  UpdateButtons;
end;

procedure TFBDAuthorTable.Delete(Sender: TObject);
begin
  if ReadOnly then
    Exit;

  FList.DeleteSelected;

  UpdateButtons;
end;

function TFBDAuthorTable.GetAuthorsCount: integer;
begin
  Result := FList.Items.Count;
end;

function TFBDAuthorTable.GetList: TAuthorDataList;
var
  Row: TListItem;
  i: integer;
begin
  SetLength(Result, FList.Items.Count);
  i := 0;
  for Row in FList.Items do
  begin
    Result[i].Last := Row.Caption;
    Result[i].First := Row.SubItems[0];
    Result[i].Middle := Row.SubItems[1];
    Result[i].Nick := Row.SubItems[2];
    Result[i].Email := Row.SubItems[3];
    Result[i].Homepage := Row.SubItems[4];
    Inc(i);
  end;
end;

procedure TFBDAuthorTable.OnSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
begin
  UpdateButtons;
end;

function TFBDAuthorTable.GetActiveRecord: TAuthorRecord;
var
  Row: TListItem;
begin
  Row := FList.Selected;
  if Assigned(Row) then
  begin
    Result.Last := Row.Caption;
    Result.First := Row.SubItems[0];
    Result.Middle := Row.SubItems[1];
    Result.Nick := Row.SubItems[2];
    Result.Email := Row.SubItems[3];
    Result.Homepage := Row.SubItems[4];
  end;
end;

procedure TFBDAuthorTable.SetActiveRecord(const Value: TAuthorRecord);
var
  Row: TListItem;
begin
  Row := FList.Selected;
  if Assigned(Row) then
  begin
    Row.Caption := Value.Last;
    Row.SubItems[0] := Value.First;
    Row.SubItems[1] := Value.Middle;
    Row.SubItems[2] := Value.Nick;
    Row.SubItems[3] := Value.Email;
    Row.SubItems[4] := Value.Homepage;
  end;
end;

procedure TFBDAuthorTable.SetList(List: TAuthorDataList);
var
  Row: TListItem;
  Author: TAuthorRecord;
begin
  FList.Items.BeginUpdate;
  try
    FList.Items.Clear;
    for Author in List do
    begin
      Row := FList.Items.Add;
      Row.Caption := Author.Last;
      Row.SubItems.Add(Author.First);
      Row.SubItems.Add(Author.Middle);
      Row.SubItems.Add(Author.Nick);
      Row.SubItems.Add(Author.Email);
      Row.SubItems.Add(Author.Homepage);
    end;

    if FList.Items.Count > 0 then
      FList.Selected := FList.Items[0];

  finally
    FList.Items.EndUpdate;
  end;

  UpdateButtons;
end;

procedure TFBDAuthorTable.SetReadOnly(const Value: Boolean);
begin
  if FReadOnly <> Value then
  begin
    FReadOnly := Value;
    UpdateButtons;
  end;
end;

procedure TFBDAuthorTable.UpdateButtons;
begin
  FAdd.Enabled := not FReadOnly;
  FChange.Enabled := (not FReadOnly) and Assigned(FList.Selected);
  FDelete.Enabled := FChange.Enabled;
  FAddAuthorFromList.Enabled := FAdd.Enabled;
end;

constructor TFBDAuthorTable.Create(AOwner: TComponent);
begin
  inherited;

  FReadOnly := False;

  Width := 330;
  Height := 200;
  BevelOuter := bvNone;
  ShowCaption := False;

  FList := TListView.Create(Self);
  with FList do
  begin
    Parent := Self;

    Margins.Left := 0;
    Margins.Right := 0;
    Margins.Top := 0;
    Margins.Bottom := 25 + Margins.Bottom * 2; // default TButton.Height

    Left := Margins.Left;
    Top := Margins.Top;
    Width := Self.Width - Margins.Left - Margins.Right;
    Height := Self.Height - Margins.Top - Margins.Bottom;

    AlignWithMargins := True;
    Align := alClient;

    with Columns.Add do
    begin
      Caption := rstrLastName;
      Width := 100;
    end;
    with Columns.Add do
    begin
      Caption := rstrFirstName;
      Width := 100;
    end;
    with Columns.Add do
    begin
      Caption := rstrMiddleName;
      Width := 100;
    end;
    with Columns.Add do
    begin
      Caption := rstrNickName;
    end;
    with Columns.Add do
    begin
      Caption := rstrEmail;
      Width := 100;
    end;
    with Columns.Add do
    begin
      Caption := rstrHomepage;
      Width := 100;
    end;

    ColumnClick := False;
    HideSelection := False;
    ViewStyle := vsReport;
    GridLines := True;
    ReadOnly := True;
    RowSelect := True;
    TabOrder := 0;
  end;
  FList.OnDblClick := Change;
  FList.OnSelectItem := OnSelectItem;

  FAdd := TButton.Create(Self);
  with FAdd do
  begin
    Parent := Self;
    Left := FList.Left;
    Top := FList.Top + FList.Height + 5;
    Width := 75;
    Caption := rstrAdd;
    TabOrder := 1;
    OnClick := Add;
    Anchors := [akLeft, akBottom];
  end;

  FChange := TButton.Create(Self);
  with FChange do
  begin
    Parent := Self;
    Left := FAdd.Left + FAdd.Width + FAdd.Margins.Right + Margins.Left;
    Top := FAdd.Top;
    Width := 75;
    Caption := rstrChange;
    TabOrder := 2;
    OnClick := Change;
    Anchors := [akLeft, akBottom];
  end;

  FDelete := TButton.Create(Self);
  with FDelete do
  begin
    Parent := Self;
    Left := FChange.Left + FChange.Width + FChange.Margins.Right + Margins.Left;
    Top := FAdd.Top;
    Width := 75;
    Caption := rstrDelete;
    TabOrder := 3;
    OnClick := Delete;
    Anchors := [akLeft, akBottom];
  end;

  FAddAuthorFromList := TButton.Create(Self);
  with FAddAuthorFromList do
  begin
    Parent := Self;
    Left := FDelete.Left + FDelete.Width + FDelete.Margins.Right + Margins.Left;
    Top := FAdd.Top;
    Width := 75;
    Caption := rstrAddFromList;
    TabOrder := 4;
    // OnClick := ; To be defined in the caller form
    Visible := False; // The code that will pass the event will change it as well
    Anchors := [akLeft, akBottom];
  end;

  UpdateButtons;
end;

{ TfrmEditAuthor }

procedure TfrmEditAuthorFull.FormShow(Sender: TObject);
begin
  ActiveControl := edFamily;
end;

function TfrmEditAuthorFull.GetAuthor: TAuthorRecord;
begin
  Result.Last := edFamily.Text;
  Result.First := edName.Text;
  Result.Middle := edMiddle.Text;
  Result.Nick := edNick.Text;
  Result.Email := edEmail.Text;
  Result.Homepage := edHomepage.Text;
end;

procedure TfrmEditAuthorFull.SetAuthor(const Value: TAuthorRecord);
begin
  edFamily.Text := Value.Last;
  edName.Text := Value.First;
  edMiddle.Text := Value.Middle;
  edNick.Text := Value.Nick;
  edEmail.Text := Value.Email;
  edHomepage.Text := Value.Homepage;
end;

end.
