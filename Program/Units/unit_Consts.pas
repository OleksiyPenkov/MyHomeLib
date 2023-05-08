(* *****************************************************************************
  *
  * MyHomeLib
  *
  * Copyright (C) 2008-2023 Oleksiy Penkov (aka Koreec)
  *
  * Author(s)           Nick Rymanov (nrymanov@gmail.com)
  * Created             12.02.2010
  * Description         Глобальные константы
  *
  * $Id: unit_Consts.pas 1181 2015-04-01 02:06:36Z koreec $
  *
  * History
  * NickR 15.02.2010    Код переформатирован
  *
  ****************************************************************************** *)

unit unit_Consts;

interface

resourcestring
  rstrNoTitle = 'Без названия';
  rstrUnknownAuthor = 'Неизвестный';

const
  CR = #13;
  LF = #10;
  CRLF = CR + LF;

  MHL_INVALID_ID = -1;

  INVALID_COLLECTION_ID  = MHL_INVALID_ID;
  NO_ACTIVECOLLECTION_ID = MHL_INVALID_ID;
  NO_SERIES_ID           = MHL_INVALID_ID;

  //
  // Значения полей по умолчанию
  //
  UNVERSIONED_COLLECTION = MHL_INVALID_ID;
  NO_SERIES_TITLE = '';
  FAVORITES_GROUP_ID = 1;
  UNKNOWN_GENRE_CODE = '0.0';

  //
  // Разделители полей в INPX
  //
  INPX_FIELD_DELIMITER   = Chr(4);
  INPX_ITEM_DELIMITER    = ':';
  INPX_SUBITEM_DELIMITER = ',';

  //
  // Наиболее часто используемые расширения файлов
  //
  COLLECTION_EXTENSION_SHORT = 'hlc2';
  COLLECTION_EXTENSION       = '.' + COLLECTION_EXTENSION_SHORT; // .hlc

  FB2_EXTENSION_SHORT        = 'fb2';
  FB2_EXTENSION              = '.' + FB2_EXTENSION_SHORT;        // .fb2

  ZIP_EXTENSION_SHORT        = 'zip';
  ZIP_EXTENSION              = '.' + ZIP_EXTENSION_SHORT;        // .zip

  SEVENZIP_EXTENSION_SHORT   = '7z';
  SEVENZIP_EXTENSION         = '.' + SEVENZIP_EXTENSION_SHORT;  // .7z

  FBD_EXTENSION_SHORT        = 'fbd';
  FBD_EXTENSION              = '.' + FBD_EXTENSION_SHORT;        // .fbd

  FB2ZIP_EXTENSION           = FB2_EXTENSION + ZIP_EXTENSION;      // .fb2.zip
  FB2SEVENZIP_EXTENSION      = FB2_EXTENSION + SEVENZIP_EXTENSION; // .fb2.7z

  GENRELIST_EXTENSION_SHORT  = 'glst';
  GENRELIST_EXTENSION        = '.' + GENRELIST_EXTENSION_SHORT;

  //
  // Алфавиты
  //
  LATIN_ALPHABET = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  CYRILLIC_ALPHABET = 'АБВГДЕЁЄЖЗИІЇЙКЛМНОПРСТУФХЦЧШЩЭЮЯ';

  LATIN_ALPHABET_SEPARATORS = '"A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"';
  // As UPPER() in SQL doesn't always convert correctly, need alphabet to include lower case letters as well
  CYRILLIC_ALPHABET_SEPARATORS = '"А","Б","В","Г","Д","Е","Ё","Є","Ж","З","И","І","Й","Ї","К","Л","М","Н","О","П","Р","С","Т","У","Ф","Х","Ц","Ч","Ш","Щ","Э","Ю","Я"'; //,"а","б","в","г","д","е","ё","ж","з","и","й","к","л","м","н","о","п","р","с","т","у","ф","х","ц","ч","ш","щ","э","ю","я"';

  //
  // Некоторые пути
  //
  DATA_DIR_NAME   = 'Data';

  //
  // Предефайненные имена файлов
  //
  SETTINGS_FILE_NAME = 'myhomelib2.ini';
  SYSTEM_DATABASE_FILENAME = 'user.dbs2';
  GENRES_FB2_FILENAME = 'genres_fb2' + GENRELIST_EXTENSION;
  GENRES_NONFB2_FILENAME = 'genres_nonfb2'  + GENRELIST_EXTENSION;
  SERVER_ERRORLOG_FILENAME = 'server_error.html';
  IMPORT_ERRORLOG_FILENAME = 'import_errors.log';
  APP_HELP_FILENAME = 'MyHomeLib.chm';
  VERINFO_FILENAME = 'version.info';
  STRUCTUREINFO_FILENAME = 'structure.info';
  PROGRAM_VERINFO_FILENAME = 'last_version.info';
  LIBRUSEC_INPX_FILENAME = 'librusec.inpx';
  COLUMNS_STORE_FILENAME = 'columns2.ini';
  DOWNLOADS_STORE_FILENAME = 'downloads.sav';
  DOWNLOAD_ERRORLOG_FILENAME = 'download_errors.log';
  COLLECTIONS_FILENAME = 'collections.ini';
  PRESETS_FILENAME = 'presets.cxml2';
  COLLECTIONINFO_FILENAME = 'collection.info'; // file holding URL, Script, etc
  TEMP_FOLDER_NAME = '_myhomelib';
  UPDATE_LOGFILE = 'update.log';
  PROGRAM_HOMEPAGE = 'https://github.com/OleksiyPenkov/myhomelib/';

  //
  // Номера вкладок в главном окне ( = tags)
  //
  PAGE_AUTHORS = 0;     // авторы
  PAGE_SERIES = 1;      // серии
  PAGE_GENRES = 2;      // жанры
  PAGE_SEARCH = 3;      // поиск
  PAGE_FAVORITES = 4;   // группы
  /// REMOVE PAGE_FILTER = 5;      // фильтр
  PAGE_DOWNLOAD = 6;    // фильтр

  PAGE_ALL = 99;        // все вкладки

  //
  // Теги колонок
  //
  COL_AUTHOR     = 20;
  COL_TITLE      = 11;
  COL_SERIES     = 12;
  COL_NO         = 13;
  COL_GENRE      = 14;
  COL_SIZE       = 15;
  COL_RATE       = 16;
  COL_DATE       = 17;
  COL_TYPE       = 18;
  COL_COLLECTION = 19;
  COL_LANG       = 21;
  COL_LIBRATE    = 22;
  COL_LIBID      = 23;

  COL_STATE = 99;

  ColumnTags: array [0 .. 13] of Integer = (
    COL_AUTHOR,
    COL_TITLE,
    COL_SERIES,
    COL_NO,
    COL_GENRE,
    COL_SIZE,
    COL_RATE,
    COL_DATE,
    COL_TYPE,
    COL_COLLECTION,
    COL_LANG,
    COL_LIBRATE,
    COL_LIBID,
    COL_STATE
  );

  //
  // названия секций колонок в файле настрок
  //
  SECTION_A_TREE = 'COLUMNS_AUTHOR_TREE';
  SECTION_A_FLAT = 'COLUMNS_AUTHOR_FLAT';

  SECTION_S_FLAT = 'COLUMNS_SERIES_FLAT';
  SECTION_S_TREE = 'COLUMNS_SERIES_TREE';

  SECTION_G_FLAT = 'COLUMNS_GENRES_FLAT';
  SECTION_G_TREE = 'COLUMNS_GENRES_TREE';

  SECTION_F_FLAT = 'COLUMNS_FAVORITES_FLAT';
  SECTION_F_TREE = 'COLUMNS_FAVORITES_TREE';

  SECTION_SR_FLAT = 'COLUMNS_SEARCH_FLAT';
  SECTION_SR_TREE = 'COLUMNS_SEARCH_TREE';

  SECTION_FL_FLAT = 'COLUMNS_FILTER_FLAT';
  SECTION_FL_TREE = 'COLUMNS_FILTER_TREE';

  //
  // Поля поиска
  //
  SF_AUTHORS     = 'Authors';
  SF_TITLE       = 'Title';
  SF_SERIES      = 'Series';
  SF_GENRE_TITLE = 'Genres';
  SF_GENRE_CODES = 'GenreCodes';
  SF_ANNOTATION  = 'Annotation';

  SF_FILE        = 'File';
  SF_FOLDER      = 'Folder';
  SF_EXTENSION   = 'Extension';

  SF_DOWNLOADED  = 'Downloaded';
  SF_KEYWORDS    = 'Keywords';
  SF_DELETED     = 'Deleted';
  SF_DATE        = 'Date';
  SF_DATE_STR    = 'Date_Str';
  SF_LANG        = 'Lang';
  SF_LIBRATE     = 'LibRate';
  SF_LIBRATE_STR = 'LibRate_Str';

  SF_READED      = 'Readed';  // Для поиска прочитанных книг
  //
  // специальные значения фильтров
  //
  ALPHA_FILTER_ALL       = '*';
  ALPHA_FILTER_NON_ALPHA = '#';

  {
    0000 0000
    \ /   |
     |    - тип содержимого
     |
     |-- тип коллекции

    Младшее слово - тип содержимого
    Пока определены следующие типы:
    0000        : книги в fb2
    0001        : книги не в fb2

    Старшее слово - тип коллекции
    Определены следующие диапазоны:
    0000        : пользовательская коллекция (всегда локальная)
    0001 - 07FF : внешние локальные коллекции
    0800 - 0FFF : внешние онлайн коллекции
    }

  //
  // тип содержимого
  //
  CONTENT_FB       = $00000000;
  CONTENT_NONFB    = $00000001;

  //
  // предопределенные библиотеки
  //
  LIBRARY_PRIVATE  = $00000000;
  LIBRARY_EXTERNAL = $00010000;

  //
  // расположения библиотеки
  //
  LOCATION_LOCAL   = $00000000;
  LOCATION_ONLINE  = $08000000;

  //
  // различные маски
  //
  CT_CONTENT_MASK  = $00000001;
  CT_LOCATION_MASK = $08000000;
  CT_TYPE_MASK     = $08030000;
  CT_MASK          = CT_CONTENT_MASK or CT_TYPE_MASK;

  //
  // Несколько предопределенных типов
  //
  CT_PRIVATE_FB            = LIBRARY_PRIVATE or LIBRARY_PRIVATE  or CONTENT_FB;    // 0000 0000 -
  CT_PRIVATE_NONFB         = LIBRARY_PRIVATE or LIBRARY_PRIVATE  or CONTENT_NONFB; // 0000 0001 -
  CT_EXTERNAL_LOCAL_FB     = LOCATION_LOCAL  or LIBRARY_EXTERNAL or CONTENT_FB;    // 0001 0000 - local lib.rus.ec
  CT_EXTERNAL_ONLINE_FB    = LOCATION_ONLINE or LIBRARY_EXTERNAL or CONTENT_FB;    // 0801 0000 - online lib.rus.ec
  CT_EXTERNAL_LOCAL_NONFB  = LOCATION_LOCAL  or LIBRARY_EXTERNAL or CONTENT_NONFB; // 0001 0001 - local Genesis
  CT_EXTERNAL_ONLINE_NONFB = LOCATION_ONLINE or LIBRARY_EXTERNAL or CONTENT_NONFB; // 0001 0001 - online Genesis

  //
  // Свойства коллекции
  //
  PROP_CLASS_SYSTEM     = $10000000;
  PROP_CLASS_COLLECTION = $20000000;
  PROP_CLASS_BOTH       = PROP_CLASS_SYSTEM or PROP_CLASS_COLLECTION;
  PROP_CLASS_MASK       = $F0000000;

  PROP_TYPE_INTEGER     = $00010000;
  PROP_TYPE_DATETIME    = $00020000;
  PROP_TYPE_BOOLEAN     = $00030000;
  PROP_TYPE_STRING      = $00040000;
  PROP_TYPE_MASK        = $0FFF0000;

  PROP_ID               = PROP_CLASS_SYSTEM     or PROP_TYPE_INTEGER  or $0000;
  PROP_DATAFILE         = PROP_CLASS_SYSTEM     or PROP_TYPE_STRING   or $0001;
  PROP_CODE             = PROP_CLASS_BOTH       or PROP_TYPE_INTEGER  or $0002;
  PROP_DISPLAYNAME      = PROP_CLASS_SYSTEM     or PROP_TYPE_STRING   or $0003;
  PROP_ROOTFOLDER       = PROP_CLASS_SYSTEM     or PROP_TYPE_STRING   or $0004;
  PROP_LIBUSER          = PROP_CLASS_SYSTEM     or PROP_TYPE_STRING   or $0005;
  PROP_LIBPASSWORD      = PROP_CLASS_SYSTEM     or PROP_TYPE_STRING   or $0006;
  PROP_URL              = PROP_CLASS_BOTH       or PROP_TYPE_STRING   or $0007;
  PROP_CONNECTIONSCRIPT = PROP_CLASS_BOTH       or PROP_TYPE_STRING   or $0008;
  PROP_DATAVERSION      = PROP_CLASS_BOTH       or PROP_TYPE_INTEGER  or $0009;
  PROP_NOTES            = PROP_CLASS_COLLECTION or PROP_TYPE_STRING   or $000A;
  PROP_CREATIONDATE     = PROP_CLASS_COLLECTION or PROP_TYPE_DATETIME or $000B;
  PROP_SCHEMA_VERSION   = PROP_CLASS_COLLECTION or PROP_TYPE_STRING   or $000C;

  PROP_LAST_AUTHOR      = PROP_CLASS_COLLECTION or PROP_TYPE_STRING   or $000D;
  PROP_LAST_AUTHOR_BOOK = PROP_CLASS_COLLECTION or PROP_TYPE_INTEGER  or $000F;

  PROP_LAST_SERIES      = PROP_CLASS_COLLECTION or PROP_TYPE_STRING   or $0010;
  PROP_LAST_SERIES_BOOK = PROP_CLASS_COLLECTION or PROP_TYPE_INTEGER  or $0011;

  PROP_BOOKS_LANG_FILTER  = PROP_CLASS_COLLECTION or PROP_TYPE_INTEGER  or $0012;
  PROP_SERIES_LANG_FILTER = PROP_CLASS_COLLECTION or PROP_TYPE_INTEGER  or $0013;
  PROP_GENRES_LANG_FILTER = PROP_CLASS_COLLECTION or PROP_TYPE_INTEGER  or $0014;
  PROP_GROUPS_LANG_FILTER = PROP_CLASS_COLLECTION or PROP_TYPE_INTEGER  or $0015;
type
  TColumnSet = set of 0 .. 255;

implementation

end.
