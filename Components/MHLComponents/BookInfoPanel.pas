(* *****************************************************************************
  *
  * MyHomeLib
  *
  * Copyright (C) 2008-2023 Oleksiy Penkov (aka Koreec)
  *
  * Author(s)           Nick Rymanov (nrymanov@gmail.com)
  * Created             14.04.2010
  * Description         Панель информации о книге
  *
  * $Id: BookInfoPanel.pas 1166 2014-05-22 03:09:17Z koreec $
  *
  * History
  *
  ****************************************************************************** *)

unit BookInfoPanel;

interface

uses
  Controls,
  Graphics,
  Classes,
  StdCtrls,
  ComCtrls,
  ExtCtrls,
  SysUtils,
  Clipbrd,
  Menus,
  FictionBook_21,
  StrUtils,
  unit_MHLHelpers,
  unit_FB2Utils,
  MHLLinkLabel;

type
  TInfoPanel = class(TCustomPanel)
  private
    FCover: TImage;
    FInfoPanel: TPanel;
    FTitle: TLabel;
    FAuthors: TMHLLinkLabel;
    FSerieLabel: TLabel;
    FSeries: TMHLLinkLabel;
    FGenreLabel: TLabel;
    FGenres: TMHLLinkLabel;
    FAnnotation: TMemo;
    FFb2Info: TListView;
    FInfoButton: TButton;

    FOnAuthorLinkClicked: TSysLinkEvent;
    FOnGenreLinkClicked: TSysLinkEvent;
    FOnSeriesLinkClicked: TSysLinkEvent;
    FOnAnnotationClicked: TNotifyEvent;
    FMenu: TPopupMenu;

    FColor: TColor;


    FInfoPriority: Boolean;

    function GetShowCover: boolean;
    procedure SetShowCover(const Value: boolean);
    procedure SetColor(Value: TColor);

    function GetShowAnnotation: Boolean;
    procedure SetShowAnnotation(const Value: Boolean);

    procedure UpdateLinkTexts;

    procedure OnLinkClicked(Sender: TObject; const Link: string; LinkType: TSysLinkType);
    procedure OnAnnotationClicked(Sender: TObject);
    procedure SetInfoPriority(const Value: Boolean);
    procedure CopyToClipboard(Sender: TObject);

  protected
    procedure Resize; override;

  public
    constructor Create(AOwner: TComponent); override;

    procedure SetBookInfo(
      const BookTitle: string;
      const Autors: string;
      const Series: string;
      const Genres: string
    );

    procedure SetBookCover(
      BookCover: TGraphic
      );

    procedure SetFb2Info(
      book: IXMLFictionBook;
      const Folder: string = '';
      const FileName: string = ''
      );


    procedure SetBookAnnotation(
      book: IXMLFictionBook
      );

    procedure Clear;

  published
    property Align;
    property Anchors;
    property BiDiMode;
    property Color read FColor write SetColor default clWindow;
    //property Constraints;
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
    //property Locked;
    property Padding;
    property ParentBiDiMode;
    property ParentBackground;
    property ParentColor;
    property ParentCtl3D;
    property ParentDoubleBuffered;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Touch;
    property VerticalAlignment;
    property Visible;

    property OnAlignInsertBefore;
    property OnAlignPosition;
    property OnCanResize;
    property OnClick;
    property OnConstrainedResize;
    property OnContextPopup;
    property OnDockDrop;
    property OnDockOver;
    property OnDblClick;
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

    property ShowCover: Boolean read GetShowCover write SetShowCover default True;
    property ShowAnnotation: Boolean read GetShowAnnotation write SetShowAnnotation default True;
    property InfoPriority: Boolean read FInfoPriority write SetInfoPriority default False;

    property OnAuthorLinkClicked: TSysLinkEvent read FOnAuthorLinkClicked write FOnAuthorLinkClicked;
    property OnSeriesLinkClicked: TSysLinkEvent read FOnSeriesLinkClicked write FOnSeriesLinkClicked;
    property OnGenreLinkClicked: TSysLinkEvent read FOnGenreLinkClicked write FOnGenreLinkClicked;
  end;

implementation

resourcestring
  rstrSerieLabel = 'Серия:';
  rstrGenreLabel = 'Жанр(ы):';
  rstrNoAnnotationHint = 'Аннотация отсутствует';
  rsrtCopyLabel = 'Копировать';
  rsrtFiledLabel = 'Поле';
  rsrtValueLabel = 'Значение';

function GetCoverWidth(Height: Integer): Integer;
begin
  Result := Height * 2 div 3;
end;

procedure TInfoPanel.CopyToClipboard(Sender: TObject);
begin
  Clipboard.AsText := FFb2Info.Selected.SubItems[0];
end;

constructor TInfoPanel.Create(AOwner: TComponent);
var
  Item: TMenuItem;
begin
  inherited Create(AOwner);

  FMenu := TPopupMenu.Create(Self);
  Item := TMenuItem.Create(Self);
  Item.Caption := rsrtCopyLabel;
  Item.ShortCut := TextToShortCut('Ctrl+C'); //ShortCut(43,[ssCtrl]) ;
  Item.OnClick :=  CopyToClipboard;
  FMenu.Items.Add(Item);

  SetBounds(0, 0, 500, 200);

  BevelOuter := bvNone;
  ShowCaption := False;

  FCover := TImage.Create(Self);
  FCover.Parent := Self;
  FCover.SetBounds(0, 0, GetCoverWidth(200), 200);
  FCover.Align := alLeft;
  FCover.AlignWithMargins := True;
  FCover.Center := True;
  FCover.Proportional := True;
  FCover.Stretch := True;

  FInfoPanel := TPanel.Create(Self);
  FInfoPanel.Parent := Self;
  FInfoPanel.SetBounds(200, 0, 300, 200);
  FInfoPanel.Align := alClient;
  FInfoPanel.BevelOuter := bvNone;
  FInfoPanel.ShowCaption := False;

  FTitle := TLabel.Create(FInfoPanel);
  FTitle.Parent := FInfoPanel;
  FTitle.Anchors := [akLeft, akTop, akRight];
  FTitle.AutoSize := False;
  FTitle.Font.Style := [fsBold];

  FAuthors := TMHLLinkLabel.Create(FInfoPanel);
  FAuthors.Parent := FInfoPanel;
  FAuthors.UseVisualStyle := True;
  FAuthors.OnLinkClick := OnLinkClicked;

  FSerieLabel := TLabel.Create(FInfoPanel);
  FSerieLabel.Parent := FInfoPanel;
  FSerieLabel.Caption := rstrSerieLabel;
  FSerieLabel.AutoSize := False;
  FSerieLabel.Font.Style := [fsBold];

  FSeries := TMHLLinkLabel.Create(FInfoPanel);
  FSeries.Parent := FInfoPanel;
  FSeries.UseVisualStyle := True;
  FSeries.OnLinkClick := OnLinkClicked;

  FGenreLabel := TLabel.Create(FInfoPanel);
  FGenreLabel.Parent := FInfoPanel;
  FGenreLabel.Caption := rstrGenreLabel;
  FGenreLabel.AutoSize := False;
  FGenreLabel.Font.Style := [fsBold];

  FGenres := TMHLLinkLabel.Create(FInfoPanel);
  FGenres.Parent := FInfoPanel;
  FGenres.UseVisualStyle := True;
  FGenres.OnLinkClick := OnLinkClicked;

  FAnnotation := TMemo.Create(FInfoPanel);
  FAnnotation.Parent := FInfoPanel;
  FAnnotation.Anchors := [akLeft, akTop, akRight, akBottom];
  FAnnotation.ReadOnly := True;
  FAnnotation.TextHint := rstrNoAnnotationHint;
  FAnnotation.ScrollBars := ssVertical;
  FAnnotation.OnDblClick := OnAnnotationClicked;
  FAnnotation.Visible := not FInfoPriority;

  FFb2Info := TListView.Create(FInfoPanel);

  with FFb2Info do
  begin
    Parent := FInfoPanel;
    AlignWithMargins := True;
    with Columns.Add do begin
      Caption := rsrtFiledLabel;
      Width := 175;
    end;
    with Columns.Add do begin
      Caption := rsrtValueLabel;
      AutoSize := True;
    end;
    ColumnClick := False;
    GroupView := True;
    ReadOnly := True;
    RowSelect := True;
    TabOrder := 0;
    ViewStyle := vsReport;
    Anchors := [akLeft, akTop, akRight, akBottom];
    OnDblClick := OnAnnotationClicked;
    Visible := FInfoPriority;
    PopupMenu := FMenu;
  end;


  //       300 200
  //0,  0, 300,  20
  //0, 20, 300,  20
  //0, 40,  60,  20 | 60, 40, 140, 20
  //0, 60,  60,  20 | 60, 60, 140, 20
  //0, 80, 300, 120

  if csDesigning in ComponentState then
  begin
    FTitle.Caption := 'Название книги';
    FAuthors.Caption := '<a>Автор книги</a> <a>Автор книги</a>';
    FSeries.Caption := '<a>Название серии</a>';
    FGenres.Caption := '<a>Название жанра</a> <a>Название жанра</a> <a>Название жанра</a>';
  end;

  FTitle.SetBounds(0, 0, 300, 20);
  FAuthors.SetBounds(0, 20, 300, 20);
  FSerieLabel.SetBounds(0, 40, 70, 20);  FSeries.SetBounds(70, 40, 140, 20);
  FGenreLabel.SetBounds(0, 60, 70, 20);  FGenres.SetBounds(70, 60, 140, 20);
  FAnnotation.SetBounds(0, 80, 300, 120);
  FFb2Info.SetBounds(0, 80, 300, 120);
  //
  //
  //
  Constraints.MinHeight := 150;
end;

procedure TInfoPanel.SetBookAnnotation;
var
  i: Integer;
begin
  FAnnotation.Clear;
  FAnnotation.Visible := not FInfoPriority;


  // ---------------------------------------------
  if (book = nil) then
    Exit;

  try
    with book.Description.Titleinfo do
      for i := 0 to Annotation.p.Count - 1 do
        FAnnotation.Lines.Add(Annotation.p[i].OnlyText);

    FAnnotation.SelStart := 0;
    FAnnotation.SelLength := 0;
  except
    //
  end;
end;

procedure TInfoPanel.Resize;
begin
  FCover.Width := GetCoverWidth(FCover.Height);
  inherited;
end;

procedure TInfoPanel.OnAnnotationClicked(Sender: TObject);
begin
  FFb2Info.Visible := not FFb2Info.Visible;
  FAnnotation.Visible := not FAnnotation.Visible;
end;

procedure TInfoPanel.OnLinkClicked(Sender: TObject; const Link: string; LinkType: TSysLinkType);
begin
  if Sender = FAuthors then
  begin
    if Assigned(FOnAuthorLinkClicked) then
      FOnAuthorLinkClicked(Self, Link, LinkType);
  end
  else if Sender = FSeries then
  begin
    if Assigned(FOnSeriesLinkClicked) then
      FOnSeriesLinkClicked(Self, Link, LinkType);
  end
  else if Sender = FGenres then
  begin
    if Assigned(FOnGenreLinkClicked) then
      FOnGenreLinkClicked(Self, Link, LinkType);
  end
  else
    Assert(False);
end;

procedure TInfoPanel.SetBookInfo(
  const BookTitle: string;
  const Autors: string;
  const Series: string;
  const Genres: string
);
begin
  FTitle.Caption := BookTitle;
  FAuthors.Caption := Autors;
  FSeries.Caption := Series;
  FGenres.Caption := Genres;
end;

procedure TInfoPanel.SetColor(Value: TColor);
begin
  if FColor <> Value then
  begin
    FColor := Value;
    FAnnotation.Color := Value;
  end;
end;

procedure TInfoPanel.SetFb2Info(book: IXMLFictionBook; const Folder, FileName: string);
var
  i: integer;
  tmpStr: string;

  procedure AddItem(listView: TListView; const Field: string; const Value: string; GroupID: integer = -1);
  var
    item: TListItem;
  begin
    if Trim(Value) <> '' then
    begin
      item := listView.Items.Add;
      item.Caption := Field;
      item.SubItems.Add(Value);
      item.GroupID := GroupID;
    end;
  end;

begin

  ffb2info.Clear;
  FFb2Info.Visible := FInfoPriority;

  with ffb2Info.Groups.Add do
  begin
    Header := rstrFileInfo;
    AddItem(ffb2Info, rstrFolder, Folder, GroupID);
    AddItem(ffb2Info, rstrFile, FileName, GroupID);
  end;

  // ---------------------------------------------
  if (book = nil) then   Exit;

  // ---------------------------------------------
  try
    with book.Description.Titleinfo, ffb2info.Groups.Add do
    begin
      Header := rstrGeneralInfo;

      AddItem(ffb2info, rstrTitle, Booktitle.Text, GroupID);

      for i := 0 to Author.Count - 1 do
      begin
        with Author[i] do
          tmpStr := FormatName(Lastname.Text, Firstname.Text, Middlename.Text, NickName.Text);
        AddItem(ffb2info, IfThen(i = 0, rstrAuthors), tmpStr, GroupID);
      end;

      for i := 0 to Sequence.Count - 1 do
      begin
        AddItem(ffb2info, IfThen(i = 0, rstrSingleSeries), Sequence[i].Name + ' ' + IntToStr(Sequence[i].Number), GroupID);
      end;

      { TODO -oNickR -cUsability : показывать алиасы вместо внутренних имен }
      for i := 0 to Genre.Count - 1 do
      begin
        AddItem(ffb2info, IfThen(i = 0, rstrGenre), Genre[i], GroupID);
      end;

      AddItem(ffb2info, rstrKeywords, Keywords.Text, GroupID);
      AddItem(ffb2info, rstrDate, Date.Text, GroupID);
      AddItem(ffb2info, rstrBookLanguage, Lang, GroupID);
      AddItem(ffb2info, rstrSourceLanguage, Srclang, GroupID);

      for i := 0 to Translator.Count - 1 do
      begin
        with Translator[i] do
          tmpStr := FormatName(Lastname.Text, Firstname.Text, Middlename.Text, NickName.Text);
        AddItem(ffb2info, IfThen(i = 0, rstrTranslators), tmpStr, GroupID);
      end;
    end; //with
  except
    //
  end;

  // ---------------------------------------------
  try
    with book.Description.Srctitleinfo, ffb2info.Groups.Add do
    begin
      Header := rstrSrclInfo;

      AddItem(ffb2info, rstrTitle, Booktitle.Text, GroupID);

      for i := 0 to Author.Count - 1 do
      begin
        with Author[i] do
          tmpStr := FormatName(Lastname.Text, Firstname.Text, Middlename.Text, NickName.Text);
        AddItem(ffb2info, IfThen(i = 0, rstrAuthors), tmpStr, GroupID);
      end;

      for i := 0 to Sequence.Count - 1 do
      begin
        AddItem(ffb2info, IfThen(i = 0, rstrSingleSeries), Sequence[i].Name + ' ' + IntToStr(Sequence[i].Number), GroupID);
      end;

      AddItem(ffb2info, rstrKeywords, Keywords.Text, GroupID);
      AddItem(ffb2info, rstrDate, Date.Text, GroupID);
      AddItem(ffb2info, rstrBookLanguage, Lang, GroupID);
      AddItem(ffb2info, rstrSourceLanguage, Srclang, GroupID);
    end; //with
  except
    //
  end;

  // ---------------------------------------------
  try
    with book.Description.Publishinfo, ffb2info.Groups.Add do
    begin
      Header := rstrPublisherInfo;

      AddItem(ffb2info, rstrTitle, Bookname.Text, GroupID);

      AddItem(ffb2info, rstrPublisher, Publisher.Text, GroupID);
      AddItem(ffb2info, rstrCity, City.Text, GroupID);
      AddItem(ffb2info, rstrYear, Year, GroupID);
      AddItem(ffb2info, rstrISBN, Isbn.Text, GroupID);

      { TODO -oNickR -cUsability : показывать номер в серии }
      for i := 0 to Sequence.Count - 1 do
        AddItem(ffb2info, IfThen(i = 0, rstrSingleSeries), Sequence[i].Name + ' ' + IntToStr(Sequence[i].Number), GroupID);
    end; //with
  except
    //
  end;

  // ---------------------------------------------
  try
    with book.Description.Documentinfo, ffb2info.Groups.Add do
    begin
      Header := rstrOCRInfo;
      for i := 0 to Author.Count - 1 do
      begin
        with Author[i] do
          tmpStr := FormatName(Lastname.Text, Firstname.Text, Middlename.Text, NickName.Text);
        AddItem(ffb2info, IfThen(i = 0, rstrAuthors), tmpStr, GroupID);
      end;

      AddItem(ffb2info, rstrProgram, Programused.Text, GroupID);
      AddItem(ffb2info, rstrDate, Date.Text, GroupID);
      AddItem(ffb2info, rstrID, book.Description.Documentinfo.Id, GroupID);
      AddItem(ffb2info, rstrVersion, Version, GroupID);

      for i := 0 to Srcurl.Count - 1 do
        AddItem(ffb2info, IfThen(i = 0, rstrSource), Srcurl[i], GroupID);

      AddItem(ffb2info, rstrSourceAuthor, Srcocr.Text, GroupID);

      for i := 0 to History.p.Count - 1 do
        AddItem(ffb2info, IfThen(i = 0, rstrHistory), History.p[i].OnlyText, GroupID);
    end; //with
  except
    //
  end;

end;

procedure TInfoPanel.SetInfoPriority(const Value: Boolean);
begin
  FInfoPriority := Value;

  FFb2Info.Visible := FInfoPriority;
  FAnnotation.Visible := not FInfoPriority;
end;

procedure TInfoPanel.SetBookCover(
  BookCover: TGraphic
  );
begin
  FCover.Picture.Assign(BookCover);
end;


procedure TInfoPanel.Clear;
begin
  FTitle.Caption := '';
  FAuthors.Caption := '';
  FSeries.Caption := '';
  FGenres.Caption := '';
  FAnnotation.Lines.Clear;
  FFb2Info.Items.Clear;
  FCover.Picture.Assign(nil);
end;


function TInfoPanel.GetShowAnnotation: Boolean;
begin
  Result := FAnnotation.Visible;
end;

procedure TInfoPanel.SetShowAnnotation(const Value: Boolean);
begin
  if GetShowAnnotation <> Value then
  begin
    FAnnotation.Visible := Value;
    if Value then
      Constraints.MinHeight := 150
    else
      Constraints.MinHeight := 80;
  end;
end;

function TInfoPanel.GetShowCover: boolean;
begin
  Result := FCover.Visible;
end;

procedure TInfoPanel.SetShowCover(const Value: boolean);
begin
  if GetShowCover <> Value then
  begin
    FCover.Visible := Value;
    UpdateLinkTexts;
  end;
end;

procedure TInfoPanel.UpdateLinkTexts;
begin
  //
  // TODO : задача этого метода превратить обрезанные линки в "Link Link и пр.", т е убрать невлезающие и добавить " и пр."
  //
end;

end.
