/* *****************************************************************************
  *
  * MyHomeLib SQLite extension library
  *
  * Copyright (C) 2010 Nick Rymanov (nrymanov@gmail.com)
  *
  * Author(s)           Nick Rymanov (nrymanov@gmail.com)
  * Created             14.09.2010
  *
  * This program is free software: you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation, either version 3 of the License, or
  * (at your option) any later version.
  *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
  * You should have received a copy of the GNU General Public License
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  *
  * $Id: MHLSQLiteExt.cpp 757 2010-09-15 05:22:46Z nrymanov@gmail.com $
  *
  * History
  *
  ****************************************************************************** */

#include "stdafx.h"

SQLITE_EXTENSION_INIT1

// ============================================================================
inline
void
localeChangeCase(sqlite3_context *context, int argc, sqlite3_value **argv, DWORD dwMapFlags)
{
    LPCWSTR pValue = static_cast<LPCWSTR>(sqlite3_value_text16(argv[0]));

    if(NULL == pValue)
    {
        sqlite3_result_null(context);
        return;
    }

    size_t nResultLen = wcslen(pValue) + 1;
    LPWSTR pResult = static_cast<LPWSTR>(sqlite3_malloc((int)(nResultLen * sizeof(WCHAR))));
    pResult[0] = '\0';

    ::LCMapString(::GetThreadLocale(), dwMapFlags, pValue, (int)nResultLen, pResult, (int)nResultLen);

    sqlite3_result_text16(context, pResult, -1, sqlite3_free);
}

// ============================================================================
void
localeUpper(sqlite3_context *context, int argc, sqlite3_value **argv)
{
	localeChangeCase(context, argc, argv, LCMAP_UPPERCASE);
}

// ============================================================================
void
localeLower(sqlite3_context *context, int argc, sqlite3_value **argv)
{
	localeChangeCase(context, argc, argv, LCMAP_LOWERCASE);
}

// ============================================================================
inline 
LPWSTR
getFullName(sqlite3_context *context, int argc, sqlite3_value **argv, int* pResultLen)
{
    LPCWSTR pLastName = static_cast<LPCWSTR>(sqlite3_value_text16(argv[0]));
    LPCWSTR pFirstName = static_cast<LPCWSTR>(sqlite3_value_text16(argv[1]));
    LPCWSTR pMiddleName = static_cast<LPCWSTR>(sqlite3_value_text16(argv[2]));

    if(NULL == pLastName && NULL == pFirstName && NULL == pMiddleName)
    {
        if(NULL != pResultLen)
        {
            *pResultLen = 0;
        }
        return NULL;
    }

    size_t nLastLen = pLastName ? wcslen(pLastName) : 0;
    size_t nFirstLen = pFirstName ? wcslen(pFirstName) : 0;
    size_t nMiddleLen = pMiddleName ? wcslen(pMiddleName) : 0;

    size_t nResultLen = 
        (
            nLastLen +
            (nFirstLen > 0 ? nFirstLen + 1 : 0) + 
            (nMiddleLen > 0 ? nMiddleLen + 1 : 0) +
            1
        );

    LPWSTR pResult = static_cast<LPWSTR>(sqlite3_malloc((int)(nResultLen * sizeof(WCHAR))));
    pResult[0] = '\0';

    wcscat_s(pResult, nResultLen, pLastName);

    if(nFirstLen > 0)
    {
        wcscat_s(pResult, nResultLen, L" ");
        wcscat_s(pResult, nResultLen, pFirstName);
    }

    if(nMiddleLen > 0)
    {
        wcscat_s(pResult, nResultLen, L" ");
        wcscat_s(pResult, nResultLen, pMiddleName);
    }

    if(NULL != pResultLen)
    {
        *pResultLen = (int)nResultLen;
    }

    return pResult;
}

// ============================================================================
void
fullAuthorName(sqlite3_context *context, int argc, sqlite3_value **argv)
{
    int nResultLen = 0;
    LPWSTR pResult = getFullName(context, argc, argv, &nResultLen);

    if(NULL == pResult)
    {
        sqlite3_result_null(context);
        return;
    }

    sqlite3_result_text16(context, pResult, nResultLen * sizeof(WCHAR), sqlite3_free);
}

// ============================================================================
void
fullAuthorNameEx(sqlite3_context *context, int argc, sqlite3_value **argv)
{
    int nResultLen = 0;
    LPWSTR pResult = getFullName(context, argc, argv, &nResultLen);

    if(NULL == pResult)
    {
        sqlite3_result_null(context);
        return;
    }

    bool bUpper = (0 != sqlite3_value_int(argv[3]));
    if(bUpper)
    {
        LPWSTR pSource = pResult;
        pResult = static_cast<LPWSTR>(sqlite3_malloc((int)(nResultLen * sizeof(WCHAR))));

        ::LCMapString(::GetThreadLocale(), LCMAP_UPPERCASE, pSource, (int)nResultLen, pResult, (int)nResultLen);

        sqlite3_free(pSource);
    }

    sqlite3_result_text16(context, pResult, nResultLen * sizeof(WCHAR), sqlite3_free);
}

// ============================================================================
int 
systemCollate(void* pUserData, int Buf1Len, const void* Buf1, int Buf2Len, const void* Buf2)
{
	return ::CompareStringW(
		::GetThreadLocale(),
		0,
		static_cast<LPCWSTR>(Buf1), Buf1Len / sizeof(wchar_t),
		static_cast<LPCWSTR>(Buf2), Buf2Len / sizeof(wchar_t)
	) - CSTR_EQUAL;
}

// ============================================================================
int 
systemCollateNoCase(void* pUserData, int Buf1Len, const void* Buf1, int Buf2Len, const void* Buf2)
{
	return ::CompareStringW(
		::GetThreadLocale(),
		NORM_IGNORECASE,
		static_cast<LPCWSTR>(Buf1), Buf1Len / sizeof(wchar_t),
		static_cast<LPCWSTR>(Buf2), Buf2Len / sizeof(wchar_t)
	) - CSTR_EQUAL;
}

// ============================================================================
// SQLite invokes this routine once when it loads the extension.
// Create new functions, collating sequences, and virtual table
// modules here. This is usually the only exported symbol in
// the shared library.
extern "C"
_declspec(dllexport)
int
sqlite3_extension_init(sqlite3 *db, char **pzErrMsg, const sqlite3_api_routines *pApi)
{
    SQLITE_EXTENSION_INIT2(pApi)

    sqlite3_create_function(db, "MHL_UPPER", 1, SQLITE_ANY, 0, localeUpper, 0, 0);
    sqlite3_create_function(db, "MHL_LOWER", 1, SQLITE_ANY, 0, localeLower, 0, 0);
    sqlite3_create_function(db, "MHL_FULLNAME", 3, SQLITE_ANY, 0, fullAuthorName, 0, 0);
    sqlite3_create_function(db, "MHL_FULLNAME", 4, SQLITE_ANY, 0, fullAuthorNameEx, 0, 0);

	sqlite3_create_collation(db, "MHL_SYSTEM",        SQLITE_UTF16_ALIGNED, 0, systemCollate);
	sqlite3_create_collation(db, "MHL_SYSTEM_NOCASE", SQLITE_UTF16_ALIGNED, 0, systemCollateNoCase);

    return 0;
}


