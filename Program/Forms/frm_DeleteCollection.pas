(* *****************************************************************************
  *
  * MyHomeLib
  *
  * Copyright (C) 2008-2023 Oleksiy Penkov (aka Koreec)
  *
  * Authors             Nick Rymanov     nrymanov@gmail.com
  * Created             08.11.2010
  * Description
  *
  * $Id: frm_DeleteCollection.pas 1072 2011-09-17 13:15:07Z eg_ $
  *
  * History
  *
  ****************************************************************************** *)

{$WARN SYMBOL_PLATFORM OFF}

unit frm_DeleteCollection;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  StdCtrls,
  Themes,
  pngimage,
  ExtCtrls,
  MHLSimplePanel;

type
  TDeleteCollectionAction = (dcaCancel, dcaDelete, dcaUnregister);

  TdlgDeleteCollection = class(TForm)
    pnMessage: TMHLSimplePanel;
    imgWarning: TImage;
    rbDelete: TRadioButton;
    txtDelete: TLabel;
    rbUnregister: TRadioButton;
    txtUnregister: TLabel;
    pnButtons: TMHLSimplePanel;
    btnOk: TButton;
    btnCancel: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dlgDeleteCollection: TdlgDeleteCollection;

function AskDeleteCollectionAction: TDeleteCollectionAction;

implementation

{$R *.dfm}

resourcestring
  rstrDlgCaption = 'Удаление коллекции';
  rstrDeleteRadioCaption = '&Удалить коллекцию';
  rstrDeleteRadioHint = 'Полностью удалить коллекцию. Книги из коллекции останутся на диске.';
  rstrUnregisterRadioCaption = '&Отключить коллекцию';
  rstrUnregisterRadioHint = 'Удалить коллекцию из списка доступных. Вы сможете подключить её заново с помощью Мастера добавления коллекций.';

function AskDeleteCollectionAction: TDeleteCollectionAction;
const
  mrDeleteCollection = 100;
  mrUnregisterCollection = 101;
var
  xpDlg: TdlgDeleteCollection;
  vistaDlg: TTaskDialog;
  dlgBtn: TTaskDialogBaseButtonItem;
begin
  Result := dcaCancel;

  if (Win32MajorVersion >= 6) and UseLatestCommonDialogs and ThemeServices.ThemesEnabled then
  begin
    vistaDlg := TTaskDialog.Create(Application);
    try
      vistaDlg.CommonButtons := [tcbCancel];
      vistaDlg.Flags := [tfAllowDialogCancellation, tfUseCommandLinks];
      vistaDlg.MainIcon := tdiWarning;
      vistaDlg.Caption := rstrDlgCaption;

      dlgBtn := vistaDlg.Buttons.Add;
      Assert(dlgBtn is TTaskDialogButtonItem);
      dlgBtn.Caption := rstrDeleteRadioCaption;
      (dlgBtn as TTaskDialogButtonItem).CommandLinkHint := rstrDeleteRadioHint;
      dlgBtn.Default := True;
      dlgBtn.ModalResult := mrDeleteCollection;

      dlgBtn := vistaDlg.Buttons.Add;
      Assert(dlgBtn is TTaskDialogButtonItem);
      dlgBtn.Caption := rstrUnregisterRadioCaption;
      (dlgBtn as TTaskDialogButtonItem).CommandLinkHint := rstrUnregisterRadioHint;
      dlgBtn.ModalResult := mrUnregisterCollection;

      if vistaDlg.Execute then
      begin
        if mrDeleteCollection = vistaDlg.ModalResult then
          Result := dcaDelete
        else if mrUnregisterCollection = vistaDlg.ModalResult  then
          Result := dcaUnregister;
      end;
    finally
      vistaDlg.Free;
    end;
  end
  else
  begin
    xpDlg := TdlgDeleteCollection.Create(Application);
    try
      if mrOk = xpDlg.ShowModal then
      begin
        if xpDlg.rbDelete.Checked then
          Result := dcaDelete
        else if xpDlg.rbUnregister.Checked then
          Result := dcaUnregister;
      end;
    finally
      xpDlg.Free;
    end;
  end;
end;

end.
