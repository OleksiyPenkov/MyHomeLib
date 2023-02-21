(* *****************************************************************************
  *
  * MyHomeLib
  *
  * Copyright (C) 2008-2023 Oleksiy Penkov (aka Koreec)
  *
  * Authors             Nick Rymanov     nrymanov@gmail.com
  * Created             20.08.2008
  * Description
  *
  * $Id: unit_NCWParams.pas 1104 2012-01-27 04:43:24Z koreec $
  *
  * History
  *
  ****************************************************************************** *)

unit unit_NCWParams;

interface

uses unit_globals;

type
  TNCWOperation = (
    otNew,              // создать новую пользовательскую коллекцию
    otExisting,         // подключить существующую коллекцию
    otInpx,             // создать коллекцию из INPX
    otInpxDownload      // создать коллекцию из предварительно скачанного INPX
  );

  TNCWCollectionType = (
    ltUser,             // нова¤ пользовательска¤ коллекци¤. тип книг определ¤етс¤ TNCWFileTypes
    ltUserFB,           // пользовательска¤ коллекци¤ FB2 книг из INPX
    ltUserAny,          // пользовательска¤ коллекци¤ не-FB2 книг из INPX
    ltExternalLocalFB,  // внешн¤¤ локальна¤ коллекци¤ FB2 книг из INPX
    ltExternalOnlineFB, // внешн¤¤ онлайн коллекци¤ FB2 книг из INPX
    ltExternalLocalAny, // внешн¤¤ локальна¤ коллекци¤ не-FB2 книг из INPX
    ltExternalOnlineAny // внешн¤¤ онлайн коллекци¤ не-FB2 книг из INPX
  );

  TNCWFileTypes = (
    ftFB2,              // в коллекции хран¤тс¤ файлы в формате FB2
    ftAny               // в коллекции хран¤тс¤ файлы в произвольном формате
  );

  PNCWParams = ^TNCWParams;
  TNCWParams = record
    Operation: TNCWOperation;
    CollectionType: TNCWCollectionType;
    FileTypes: TNCWFileTypes;
    DefaultGenres: Boolean;
    GenreFile: string;

    DisplayName: string;
    CollectionFile: string;
    CollectionRoot: string;

    INPXFile: string;

    AutoImport: boolean;

    //
    // необходимо перенести загрузку и установку этих значений в TImportInpxThread
    //
    //Notes: string;
    //URL: string;
    //Script: string;
    INPXUrl: string;

    //
    // реальный тип коллекции
    //
    CollectionCode: COLLECTION_TYPE;

    //
    // ID новой коллекции (созданной или подключенной)
    //
    CollectionID: Integer;
  end;

implementation

end.

