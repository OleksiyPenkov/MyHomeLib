(* *****************************************************************************
  *
  * MyHomeLib
  *
  * Copyright (C) 2008-2026 Oleksiy Penkov (aka Koreec)
  *
  * Author(s)           Oleksiy Penkov  oleksiy.penkov@gmail.com
  * Created             25.07.2026
  * Description         Інтерфейс доступу потоку завантаження до інтерфейсу користувача
  *
  * History
  *
  ****************************************************************************** *)

unit unit_DownloadView;

interface

uses
  unit_Globals;

type
  //
  // Книга, яку менеджер завантажень зараз обробляє.
  //
  // Потік бачить лише ці дані - жодних вузлів дерева та інших об'єктів VCL,
  // час життя яких він не контролює.
  //
  TDownloadItem = record
    BookKey: TBookKey;
    Author: string;
    Title: string;
  end;

  //
  // Усе, що потік завантаження робить з інтерфейсом користувача.
  //
  // Реалізує головна форма. Потік звертається до методів виключно через
  // Synchronize, тому жоден елемент керування не чіпається з фонового потоку.
  //
  // Черга завантажень (дерево tvDownloadList) лишається за формою: саме вона
  // володіє вузлами, тримає курсор поточної книги та оновлює лічильник.
  //
  IDownloadView = interface
    ['{6C1B0C4E-2A83-4E2F-9F3D-7A8B5D0E4C11}']

    //
    // Черга
    //

    // Обрати наступну книгу для завантаження та позначити її активною.
    // False - у черзі більше нічого немає.
    function SelectNextDownload(out Item: TDownloadItem): Boolean;

    // Завершити активну книгу: успішну прибрати з черги, помилкову лишити.
    procedure CompleteCurrentDownload(Success: Boolean);

    // Позначити активну книгу як перервану користувачем.
    procedure CancelCurrentDownload;

    //
    // Відображення стану
    //

    function IsMainFormVisible: Boolean;
    procedure ShowDownloadInfo(const Author, Title: string);
    procedure ShowDownloadState(const State: string);
    procedure ShowDownloadProgress(Position: Integer);

    // Повернути панель завантаження до стану спокою.
    procedure ResetDownloadState;

    procedure SetTrayHint(const Hint: string);

    // Стан кнопок "Почати"/"Пауза".
    procedure SetDownloadRunning(Running: Boolean);

    // Кнопки впорядкування та видалення черги: під час завантаження недоступні.
    procedure SetQueueControlsEnabled(Enabled: Boolean);

    //
    // Запит до користувача. Викликається лише через Synchronize.
    //
    function AskIgnoreDownloadErrors: Integer;
  end;

implementation

end.
