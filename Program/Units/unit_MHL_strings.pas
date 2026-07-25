(* *****************************************************************************
  *
  * MyHomeLib
  *
  * Copyright (C) 2008-2026 Oleksiy Penkov (aka Koreec)
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
  rstrMainUnableToCopy = 'Копіювання книг із обраного неможливе.';
  rstrMainConnectToDb = 'Подключение БД...';
  rstrMainLoadingCollection = 'Завантаження колекції...';
  rstrMainCheckUpdates = 'Перевірка оновлень...';

  rstrCancelOperationWarningMsg = 'Ви дійсно хочете перервати операцію?';

  rstrReadyMessage = 'Готово';

  rstrDatabaseCheckOk = 'Перевірка не виявила помилок у базі даних колекції.';
  rstrDatabaseCheckFailed = 'Перевірка цілісності бази виявила проблеми:'#13#10#13#10'%s'#13#10#13#10 +
    'SQLite не відновлює пошкоджені файли автоматично. Скористайтеся резервною копією бази або повторним імпортом колекції.';

  rstrHelpFileNotFound = 'Файл довідки не знайдено:'#13#10'%s';

  //
  // Названия коллекций по-умолчанию
  //
  rstrLocalLibRusEcDefName = 'Локальна колекція Лібрусек';
  rstrOnlineLibRusEcDefName = 'Онлайн колекція Лібрусек';
  rstrOnlineGenesisDefName = 'Онлайн колекція Genesis';

  rstrLocalLibRusEcDefLocation = 'librusec_local';
  rstrOnlineLibRusEcDefLocation = 'librusec_online';
  rstrOnlineGenesisDefLocation = 'genesis_online';

  //
  //
  //
  rstrBookProcessedMsg1 = 'Оброблено книг: %u';
  rstrBookProcessedMsg2 = 'Оброблено книг: %u из %u';

  //
  // Форма редактирования/создания FBD и пунк меню в главной форме
  //
  rstrEditFBD = 'Редагувати FBD';
  rstrConvert2FBD = 'Перетворити FBD';

implementation

end.
