(* *****************************************************************************
  *
  * MyHomeLib
  *
  * Copyright (C) 2008-2023 Oleksiy Penkov (aka Koreec)
  *
  * Author(s)           Nick Rymanov (nrymanov@gmail.com)
  * Created             12.02.2010
  * Description
  *
  * $Id: unit_MHL_strings.pas 748 2010-09-14 07:02:22Z nrymanov@gmail.com $
  *
  * History
  * NickR 15.02.2010    Код переформатирован
  *
  ****************************************************************************** *)

unit unit_MHL_strings;

interface

resourcestring
  rstrMainUnableToCopy = 'Копирование книг из избранного невозможно.';
  rstrMainConnectToDb = 'Подключение БД...';
  rstrMainLoadingCollection = 'Загрузка коллекции...';
  rstrMainCheckUpdates = 'Проверка обновлений...';

  rstrCancelOperationWarningMsg = 'Вы действительно хотите прервать операцию?';

  rstrReadyMessage = 'Готово';

  //
  // Названия коллекций по-умолчанию
  //
  rstrLocalLibRusEcDefName = 'Локальная коллекция Либрусек';
  rstrOnlineLibRusEcDefName = 'Онлайн коллекция Либрусек';
  rstrOnlineGenesisDefName = 'Онлайн коллекция Genesis';

  rstrLocalLibRusEcDefLocation = 'librusec_local';
  rstrOnlineLibRusEcDefLocation = 'librusec_online';
  rstrOnlineGenesisDefLocation = 'genesis_online';

  //
  //
  //
  rstrBookProcessedMsg1 = 'Обработано книг: %u';
  rstrBookProcessedMsg2 = 'Обработано книг: %u из %u';

  //
  // Форма редактирования/создания FBD и пунк меню в главной форме
  //
  rstrEditFBD = 'Редактировать FBD';
  rstrConvert2FBD = 'Преобразовать FBD';

implementation

end.
