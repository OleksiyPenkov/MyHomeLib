(* *****************************************************************************
  *
  * MyHomeLib
  *
  * Copyright (C) 2008-2023 Oleksiy Penkov (aka Koreec)
  *
  * Author(s)           Nick Rymanov (nrymanov@gmail.com)
  * Created             15.04.2010
  * Description
  *
  * $Id: MHLComponents_Register.pas 818 2010-09-28 10:23:48Z nrymanov@gmail.com $
  *
  * History
  *
  ****************************************************************************** *)

unit MHLComponents_Register;

interface

uses
  Classes;

procedure Register;

implementation

uses
  files_list,
  unit_StaticTip,
  unit_AutoCompleteEdit,
  MHLLinkLabel,
  MHLSplitter,
  BookTreeView,
  BookInfoPanel,
  MHLSimplePanel,
  MHLButtonedEdit,
  FBDAuthorTable,
  FBDDocument;

const
  PAGE_NAME = 'MHLComponents';

procedure Register;
begin
  RegisterComponents(
    PAGE_NAME,
    [
    TFilesList,
    TMHLStaticTip,
    TMHLAutoCompleteEdit,
    TMHLLinkLabel,
    TMHLSplitter,
    TMHLSimplePanel,
    TBookTree,
    TInfoPanel,
    TMHLButtonedEdit,
    TFBDAuthorTable,
    TFBDDocument
    ]
  );
end;

end.

