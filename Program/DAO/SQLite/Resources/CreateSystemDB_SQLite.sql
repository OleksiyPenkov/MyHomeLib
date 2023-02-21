-------------------------------------------------------------------------------
--
-- MyHomeLib
--
-- Copyright (C) 2008-2023 Aleksey Penkov
--
-- Author(s)           eg
--                     Nick Rymanov    nrymanov@gmail.com
-- Created             04.09.2010
-- Description
--
-- $Id: CreateSystemDB_SQLite.sql 950 2011-02-12 03:36:34Z koreec $
--
-- History
--
-------------------------------------------------------------------------------
DROP TABLE IF EXISTS Books;
--@@

DROP TABLE IF EXISTS Groups;
--@@

DROP TABLE IF EXISTS BookGroups;
--@@

DROP TABLE IF EXISTS Bases;
--@@

CREATE TABLE Books (
  BookID     INTEGER      NOT NULL,
  DatabaseID INTEGER      NOT NULL,
  LibID      INTEGER      NOT NULL,
  Title      VARCHAR(150) NOT NULL COLLATE MHL_SYSTEM_NOCASE,
  SeriesID   INTEGER,
  SeqNumber  INTEGER,
  UpdateDate VARCHAR(23)  NOT NULL,
  LibRate    INTEGER      NOT NULL,
  Lang       VARCHAR(2)            COLLATE MHL_SYSTEM_NOCASE,
  Folder     VARCHAR(255)          COLLATE MHL_SYSTEM_NOCASE,
  FileName   VARCHAR(255) NOT NULL COLLATE MHL_SYSTEM_NOCASE,
  InsideNo   INTEGER      NOT NULL,
  Ext        VARCHAR(10)           COLLATE MHL_SYSTEM_NOCASE,
  BookSize   INTEGER,
  IsLocal    INTEGER      NOT NULL,
  IsDeleted  INTEGER      NOT NULL,
  KeyWords   VARCHAR(255)          COLLATE MHL_SYSTEM_NOCASE,
  Rate       INTEGER      NOT NULL,
  Progress   INTEGER      NOT NULL,
  Annotation VARCHAR(4096)         COLLATE MHL_SYSTEM_NOCASE,
  Review     BLOB,
  ExtraInfo  BLOB,

  PRIMARY KEY (BookID, DatabaseID)
);
--@@

CREATE INDEX IXBooks_FileName ON Books (FileName);
--@@

CREATE TABLE Groups (
  GroupID     INTEGER      NOT NULL                           PRIMARY KEY AUTOINCREMENT,
  GroupName   VARCHAR(255) NOT NULL COLLATE MHL_SYSTEM_NOCASE UNIQUE,
  AllowDelete INTEGER      NOT NULL,
  Notes       BLOB
);
--@@

CREATE TABLE BookGroups (
  BookID     INTEGER NOT NULL,
  DatabaseID INTEGER NOT NULL,
  GroupID    INTEGER NOT NULL,

  PRIMARY KEY (GroupID, BookID, DatabaseID)
);
--@@

CREATE INDEX IXBookGroups_BookID_DatabaseID ON BookGroups (DatabaseID, BookID);
--@@

CREATE TABLE Bases (
  DatabaseID       INTEGER      NOT NULL                           PRIMARY KEY AUTOINCREMENT,
  BaseName         VARCHAR(64)  NOT NULL COLLATE MHL_SYSTEM_NOCASE UNIQUE,
  DBFileName       VARCHAR(128) NOT NULL COLLATE MHL_SYSTEM_NOCASE,
  RootFolder       VARCHAR(128) NOT NULL COLLATE MHL_SYSTEM_NOCASE,
  DataVersion      INTEGER,
  Code             INTEGER      NOT NULL,
  LibUser          VARCHAR(50),
  LibPassword      VARCHAR(50),

  --
  -- следующие пол¤ должны хранитьс¤ в самой коллекции. «десь им не место.
  --
  Notes            VARCHAR(255)          COLLATE MHL_SYSTEM_NOCASE,
  CreationDate     VARCHAR(23)  NOT NULL,
  URL              VARCHAR(255)          COLLATE MHL_SYSTEM_NOCASE,
  ConnectionScript BLOB
);
--@@

CREATE TRIGGER TRBases_BD BEFORE DELETE ON Bases
  BEGIN
    DELETE FROM BookGroups WHERE DatabaseID = OLD.DatabaseID;
    DELETE FROM Books WHERE DatabaseID = OLD.DatabaseID;
  END;
--@@

