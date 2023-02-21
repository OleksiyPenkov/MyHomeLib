(* *****************************************************************************
  *
  * MyHomeLib
  *
  * Copyright (C) 2008-2023 Oleksiy Penkov (aka Koreec)
  *
  * Author(s)           Nick Rymanov (nrymanov@gmail.com)
  * Created             05.07.2010
  * Description         TButtonedEdit, без правой кнопки и загружающий картинку для левой кнопки из ресурсов.
  *
  * $Id: MHLButtonedEdit.pas 785 2010-09-17 09:06:06Z nrymanov@gmail.com $
  *
  * History
  *
  ****************************************************************************** *)

unit MHLButtonedEdit;

interface

uses
  Classes,
  Controls,
  StdCtrls,
  ExtCtrls,
  SysUtils,
  ImgList;

type
  TMHLButtonedEdit = class(TCustomButtonedEdit)
  private
    class var
      FImages: TImageList;

  private
    class constructor Create;
    class destructor Destroy;

  protected
    function GetEditButtonClass: TEditButtonClass; override;

  public
    constructor Create(AOwner: TComponent); override;

  published
    property Align;
    property Alignment;
    property Anchors;
    property AutoSelect;
    property AutoSize;
    property BevelEdges;
    property BevelInner;
    property BevelKind default bkNone;
    property BevelOuter;
    property BevelWidth;
    property BiDiMode;
    property BorderStyle;
    property CharCase;
    property Color;
    property Constraints;
    property Ctl3D;
    property DoubleBuffered;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property HideSelection;
    ///property Images;
    property ImeMode;
    property ImeName;
    //property LeftButton;
    property MaxLength;
    property OEMConvert;
    property NumbersOnly;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentDoubleBuffered;
    property ParentFont;
    property ParentShowHint;
    property PasswordChar;
    property PopupMenu;
    property ReadOnly;
    property RightButton;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Text;
    property TextHint;
    property Touch;
    property Visible;

    property OnChange;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnGesture;
    ///property OnLeftButtonClick;
    property OnMouseActivate;
    property OnMouseDown;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnMouseMove;
    property OnMouseUp;
    property OnRightButtonClick;
    property OnStartDock;
    property OnStartDrag;
  end;

implementation

{$R *.res}

uses
  Graphics, pngimage;

type
  TMHLEditButton = class(TEditButton)
  published
    property ImageIndex default 0;
    property Visible default True;
  end;

{ TMHLButtonedEdit }

class constructor TMHLButtonedEdit.Create;
var
  png: TPngImage;
  bitmap: TBitmap;
begin
  FImages := TImageList.Create(nil);
  FImages.ColorDepth := cd32Bit;

  png := TPngImage.Create;
  try
    png.LoadFromResourceName(HInstance, 'CODE_EDITOR');

    bitmap := TBitmap.Create;
    try
      bitmap.Assign(png);
      FImages.Add(bitmap, nil);
    finally
      bitmap.Free;
    end;
  finally
    png.Free;
  end;
end;

constructor TMHLButtonedEdit.Create(AOwner: TComponent);
begin
  inherited;
  Images := FImages;
  RightButton.ImageIndex := 0;
  RightButton.Visible := True;
end;

class destructor TMHLButtonedEdit.Destroy;
begin
  FImages.Free;
  inherited;
end;

function TMHLButtonedEdit.GetEditButtonClass: TEditButtonClass;
begin
  Result := TMHLEditButton;
end;

end.
