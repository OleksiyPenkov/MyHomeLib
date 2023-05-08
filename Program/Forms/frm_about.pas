(* *****************************************************************************
  *
  * MyHomeLib
  *
  * Copyright (C) 2008-2023 Oleksiy Penkov (aka Koreec)
  *
  * Authors Oleksiy Penkov   oleksiy.penkov@gmail.com
  *         Nick Rymanov     nrymanov@gmail.com
  *
  * $Id: frm_about.pas 1186 2015-05-14 05:20:24Z koreec $
  *
  * History
  *
  ****************************************************************************** *)

unit frm_about;

interface

uses
  Windows,
  Classes,
  Controls,
  Forms,
  StdCtrls,
  ExtCtrls,
  unit_MHLHelpers,
  MHLSimplePanel,
  MHLLinkLabel;

type
  TfrmAbout = class(TForm)
    RzPanel1: TMHLSimplePanel;
    RzURLLabel: TMHLLinkLabel;
    RzBitBtn1: TButton;
    versionInfoLabel: TLabel;
    RzLabel1: TLabel;
    RzLabel2: TLabel;
    RzLabel3: TLabel;
    RzLabel4: TLabel;
    RzLabel6: TLabel;
    RzLabel7: TLabel;
    RzLabel8: TLabel;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure RzURLLabelLinkClick(Sender: TObject; const Link: string; LinkType: TSysLinkType);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAbout: TfrmAbout;

implementation

uses
  SysUtils,
  unit_Helpers,
  unit_Consts;

resourcestring
  rstrAppVersionInfo   = 'Версия: %s';
  rstrAppVersionInfo64 = 'Версия: %s x64';

{$R *.dfm}

procedure TfrmAbout.FormCreate(Sender: TObject);
begin
  {$IFDEF  WIN64}
     versionInfoLabel.Caption := Format(rstrAppVersionInfo64, [unit_MHLHelpers.GetFileVersion(Application.ExeName)]);
  {$ELSE}
    versionInfoLabel.Caption := Format(rstrAppVersionInfo, [unit_MHLHelpers.GetFileVersion(Application.ExeName)]);
  {$ENDIF}
end;

procedure TfrmAbout.FormShow(Sender: TObject);
begin
  RzURLLabel.Caption := Format('<a href="%s">%s</a>', [PROGRAM_HOMEPAGE, PROGRAM_HOMEPAGE]);
end;

procedure TfrmAbout.RzURLLabelLinkClick(Sender: TObject; const Link: string; LinkType: TSysLinkType);
begin
  SimpleShellExecute(Handle, Link);
end;

end.
