(* *****************************************************************************
  *
  * MyHomeLib
  *
  * Copyright (C) 2008-2019 Oleksiy Penkov (aka Koreec)
  *
  * Authors Aleksey Penkov   alex.penkov@gmail.com
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
    RzURLLabel1: TMHLLinkLabel;
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
    procedure RzURLLabel1LinkClick(Sender: TObject; const Link: string; LinkType: TSysLinkType);
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
  unit_Helpers;

resourcestring
  rstrAppVersionInfo = 'Версия: %s';

{$R *.dfm}

procedure TfrmAbout.FormCreate(Sender: TObject);
begin
  versionInfoLabel.Caption := Format(rstrAppVersionInfo, [unit_MHLHelpers.GetFileVersion(Application.ExeName)]);
end;

procedure TfrmAbout.RzURLLabel1LinkClick(Sender: TObject; const Link: string; LinkType: TSysLinkType);
begin
  SimpleShellExecute(Handle, Link);
end;

end.
