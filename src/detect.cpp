#include <Rcpp.h>
using namespace Rcpp;

/*
* Copyright (C) 2006-2016 Wu Yongwei <wuyongwei@gmail.com>
*
* This software is provided 'as-is', without any express or implied
* warranty.  In no event will the authors be held liable for any
* damages arising from the use of this software.
*
* Permission is granted to anyone to use this software for any purpose,
* including commercial applications, and to alter it and redistribute
* it freely, subject to the following restrictions:
*
* 1. The origin of this software must not be misrepresented; you must
*    not claim that you wrote the original software.  If you use this
*    software in a product, an acknowledgement in the product
*    documentation would be appreciated but is not required.
* 2. Altered source versions must be plainly marked as such, and must
*    not be misrepresented as being the original software.
* 3. This notice may not be removed or altered from any source
*    distribution.
*
*
* The latest version of this software should be available at:
*      <URL:https://github.com/adah1972/tellenc>
*
*/

/**
* @file    tellenc.cpp
*
* Program to detect the encoding of text.  It currently supports ASCII,
* UTF-8, UTF-16/32 (little-endian or big-endian), Latin1, Windows-1252,
* CP437, GB2312, GBK, Big5, and SJIS, among others.
*
* @version 1.21, 2016/03/07
* @author  Wu Yongwei
*/

#include <algorithm>        // sort
#include <map>              // map
#include <memory>           // pair
#include <vector>           // vector
#include <ctype.h>          // isprint
#include <errno.h>          // errno
#include <stdio.h>          // fopen/fclose/fprintf/printf/puts
#include <stdlib.h>         // exit
#include <string.h>         // memcmp/strcmp/strerror

#ifndef _WIN32
#define __cdecl
#endif

#ifndef TELLENC_BUFFER_SIZE
#define TELLENC_BUFFER_SIZE 200000
#endif

using namespace std;

typedef unsigned short uint16_t;
typedef unsigned int   uint32_t;
typedef pair<uint16_t, uint32_t>  char_count_t;
typedef map<uint16_t, uint32_t>   char_count_map_t;
typedef vector<char_count_t>      char_count_vec_t;

struct freq_analysis_data_t {
  uint16_t    dbyte;
  const char* enc;
};

struct greater_char_count {
  bool operator()(const char_count_t& lhs, const char_count_t& rhs)
  {
    if (lhs.second > rhs.second) {
      return true;
    } else {
      return false;
    }
  }
};

enum UTF8_State {
  UTF8_INVALID,
  UTF8_1,
  UTF8_2,
  UTF8_3,
  UTF8_4,
  UTF8_TAIL
};

static const size_t MAX_CHAR = 256;
static const unsigned char NON_TEXT_CHARS[] = { 0, 26, 127, 255 };
static const char NUL = '\0';
static const char DOS_EOF = '\x1A';
static const int EVEN = 0;
static const int ODD  = 1;

static UTF8_State utf8_char_table[MAX_CHAR];

static freq_analysis_data_t freq_analysis_data[] = {
  { 0x9a74, "windows-1250" },         // "št" (Czech)
  { 0xe865, "windows-1250" },         // "če" (Czech)
  { 0xf865, "windows-1250" },         // "ře" (Czech)
  { 0xe167, "windows-1250" },         // "ág" (Hungarian)
  { 0xe96c, "windows-1250" },         // "él" (Hungarian)
  { 0xb36f, "windows-1250" },         // "ło" (Polish)
  { 0xea7a, "windows-1250" },         // "ęz" (Polish)
  { 0xf377, "windows-1250" },         // "ów" (Polish)
  { 0x9d20, "windows-1250" },         // "ť " (Slovak)
  { 0xfa9d, "windows-1250" },         // "úť" (Slovak)
  { 0x9e69, "windows-1250" },         // "ži" (Slovenian)
  { 0xe869, "windows-1250" },         // "či" (Slovenian)
  { 0xe020, "windows-1252" },         // "à " (French)
  { 0xe920, "windows-1252" },         // "é " (French)
  { 0xe963, "windows-1252" },         // "éc" (French)
  { 0xe965, "windows-1252" },         // "ée" (French)
  { 0xe972, "windows-1252" },         // "ér" (French)
  { 0xe4e4, "windows-1252" },         // "ää" (Finnish)
  { 0xe474, "windows-1252" },         // "ät" (German)
  { 0xfc72, "windows-1252" },         // "ür" (German)
  { 0xed6e, "windows-1252" },         // "ín" (Spanish)
  { 0xf36e, "windows-1252" },         // "ón" (Spanish)
  { 0x8220, "cp437" },                // "é " (French)
  { 0x8263, "cp437" },                // "éc" (French)
  { 0x8265, "cp437" },                // "ée" (French)
  { 0x8272, "cp437" },                // "ér" (French)
  { 0x8520, "cp437" },                // "à " (French)
  { 0x8172, "cp437" },                // "ür" (German)
  { 0x8474, "cp437" },                // "ät" (German)
  { 0xc4c4, "cp437" },                // "──"
  { 0xcdcd, "cp437" },                // "══"
  { 0xdbdb, "cp437" },                // "██"
  { 0xa1a1, "gbk" },                  // "　"
  { 0xa1a3, "gbk" },                  // "。"
  { 0xa3ac, "gbk" },                  // "，"
  { 0xa3ba, "gbk" },                  // "："
  { 0xb5c4, "gbk" },                  // "的"
  { 0xc1cb, "gbk" },                  // "了"
  { 0xd2bb, "gbk" },                  // "一"
  { 0xcac7, "gbk" },                  // "是"
  { 0xb2bb, "gbk" },                  // "不"
  { 0xb8f6, "gbk" },                  // "个"
  { 0xc8cb, "gbk" },                  // "人"
  { 0xd5e2, "gbk" },                  // "这"
  { 0xd3d0, "gbk" },                  // "有"
  { 0xced2, "gbk" },                  // "我"
  { 0xc4e3, "gbk" },                  // "你"
  { 0xcbfb, "gbk" },                  // "他"
  { 0xcbfd, "gbk" },                  // "她"
  { 0xc9cf, "gbk" },                  // "上"
  { 0xbfb4, "gbk" },                  // "看"
  { 0xd6ae, "gbk" },                  // "之"
  { 0xbfc9, "gbk" },                  // "可"
  { 0xbaf3, "gbk" },                  // "后"
  { 0xd6d0, "gbk" },                  // "中"
  { 0xd0d0, "gbk" },                  // "行"
  { 0xb1d2, "gbk" },                  // "币"
  { 0xb3f6, "gbk" },                  // "出"
  { 0xb7d1, "gbk" },                  // "费"
  { 0xb8d0, "gbk" },                  // "感"
  { 0xbef5, "gbk" },                  // "觉"
  { 0xc4ea, "gbk" },                  // "年"
  { 0xd4c2, "gbk" },                  // "月"
  { 0xc8d5, "gbk" },                  // "日"
  { 0xa140, "big5" },                 // "　"
  { 0xa141, "big5" },                 // "，"
  { 0xa143, "big5" },                 // "。"
  { 0xa147, "big5" },                 // "："
  { 0xaaba, "big5" },                 // "的"
  { 0xa446, "big5" },                 // "了"
  { 0xa440, "big5" },                 // "一"
  { 0xac4f, "big5" },                 // "是"
  { 0xa4a3, "big5" },                 // "不"
  { 0xa448, "big5" },                 // "人"
  { 0xa7da, "big5" },                 // "我"
  { 0xa741, "big5" },                 // "你"
  { 0xa54c, "big5" },                 // "他"
  { 0xa66f, "big5" },                 // "她"
  { 0xadd3, "big5" },                 // "個"
  { 0xa457, "big5" },                 // "上"
  { 0xa662, "big5" },                 // "在"
  { 0xbba1, "big5" },                 // "說"
  { 0xa65e, "big5" },                 // "回"
  { 0x8140, "sjis" },                 // "　"
  { 0x8141, "sjis" },                 // "、"
  { 0x8142, "sjis" },                 // "。"
  { 0x8145, "sjis" },                 // "・"
  { 0x8146, "sjis" },                 // "："
  { 0x815b, "sjis" },                 // "ー"
  { 0x82b5, "sjis" },                 // "し"
  { 0x82bd, "sjis" },                 // "た"
  { 0x82c8, "sjis" },                 // "な"
  { 0x82c9, "sjis" },                 // "に"
  { 0x82cc, "sjis" },                 // "の"
  { 0x82dc, "sjis" },                 // "ま"
  { 0x82f0, "sjis" },                 // "を"
  { 0x8367, "sjis" },                 // "ト"
  { 0x8393, "sjis" },                 // "ン"
  { 0x89ef, "sjis" },                 // "会"
  { 0x906c, "sjis" },                 // "人"
  { 0x9094, "sjis" },                 // "数"
  { 0x93fa, "sjis" },                 // "日"
  { 0x95f1, "sjis" },                 // "報"
  { 0xa1bc, "euc-jp" },               // "ー"
  { 0xa4bf, "euc-jp" },               // "た"
  { 0xa4ca, "euc-jp" },               // "な"
  { 0xa4cb, "euc-jp" },               // "に"
  { 0xa4ce, "euc-jp" },               // "の"
  { 0xa4de, "euc-jp" },               // "ま"
  { 0xa4f2, "euc-jp" },               // "を"
  { 0xa5c8, "euc-jp" },               // "ト"
  { 0xa5f3, "euc-jp" },               // "ン"
  { 0xb2f1, "euc-jp" },               // "会"
  { 0xbfcd, "euc-jp" },               // "人"
  { 0xbff4, "euc-jp" },               // "数"
  { 0xc6fc, "euc-jp" },               // "日"
  { 0xcaf3, "euc-jp" },               // "報"
  { 0xc0cc, "euc-kr" },               // "이"
  { 0xb0fa, "euc-kr" },               // "과"
  { 0xb1e2, "euc-kr" },               // "기"
  { 0xb4c2, "euc-kr" },               // "는"
  { 0xb7ce, "euc-kr" },               // "로"
  { 0xb1db, "euc-kr" },               // "글"
  { 0xc5e4, "euc-kr" },               // "토"
  { 0xc1a4, "euc-kr" },               // "정"
  { 0xc920, "koi8-r" },               // "и "
  { 0xc7cf, "koi8-r" },               // "го"
  { 0xcbcf, "koi8-r" },               // "ко"
  { 0xd3cb, "koi8-r" },               // "ск"
  { 0xd3d4, "koi8-r" },               // "ст"
  { 0xa6a7, "koi8-u" },               // "ії"
  { 0xa6ce, "koi8-u" },               // "ін"
  { 0xa6d7, "koi8-u" },               // "ів"
  { 0xa7ce, "koi8-u" },               // "їн"
  { 0xd0cf, "koi8-u" },               // "по"
  { 0xd4c9, "koi8-u" },               // "ти"
};

static size_t nul_count_byte[2];
static size_t nul_count_word[2];

static bool is_binary = false;
static bool is_valid_utf8 = true;
static bool is_valid_latin1 = true;
static uint32_t dbyte_cnt = 0;
static uint32_t dbyte_hihi_cnt = 0;

bool verbose = false;

static inline bool is_non_text(char ch)
{
  for (size_t i = 0; i < sizeof(NON_TEXT_CHARS); ++i) {
    if (ch == NON_TEXT_CHARS[i]) {
      return true;
    }
  }
  return false;
}

void init_utf8_char_table()
{
  int ch = 0;
  utf8_char_table[ch] = UTF8_INVALID;
  ++ch;
  for (; ch <= 0x7f; ++ch) {
    utf8_char_table[ch] = UTF8_1;
  }
  for (; ch <= 0xbf; ++ch) {
    utf8_char_table[ch] = UTF8_TAIL;
  }
  for (; ch <= 0xc1; ++ch) {
    utf8_char_table[ch] = UTF8_INVALID;
  }
  for (; ch <= 0xdf; ++ch) {
    utf8_char_table[ch] = UTF8_2;
  }
  for (; ch <= 0xef; ++ch) {
    utf8_char_table[ch] = UTF8_3;
  }
  for (; ch <= 0xf4; ++ch) {
    utf8_char_table[ch] = UTF8_4;
  }
  for (; ch <= 0xff; ++ch) {
    utf8_char_table[ch] = UTF8_INVALID;
  }
}

static void init_sbyte_char_count(char_count_t sbyte_char_cnt[])
{
  for (size_t i = 0; i < MAX_CHAR; ++i) {
    sbyte_char_cnt[i].first = i;
    sbyte_char_cnt[i].second = 0;
  }
}

// static void print_sbyte_char_cnt(const char_count_t sbyte_char_cnt[])
// {
//   for (size_t i = 0; i < MAX_CHAR; ++i) {
//     unsigned char ch = (unsigned char)sbyte_char_cnt[i].first;
//     if (sbyte_char_cnt[i].second == 0)
//       break;
//     printf("%.2x ('%c'): %-6u    ", ch,
//            isprint(ch) ? ch : '?', sbyte_char_cnt[i].second);
//   }
//   printf("\n");
// }
// 
// static void print_dbyte_char_cnt(const char_count_vec_t& dbyte_char_cnt)
// {
//   for (char_count_vec_t::const_iterator it = dbyte_char_cnt.begin();
//        it != dbyte_char_cnt.end(); ++it) {
//     printf("%.4x: %-6u        ", it->first, it->second);
//   }
//   printf("\n");
// }

static const char* check_ucs_bom(const unsigned char* const buffer,
                                 const size_t len)
{
  const struct pattern_t {
    const char* name;
    const char* pattern;
    size_t pattern_len;
  } patterns[] = {
    { "ucs-4",     "\x00\x00\xFE\xFF",  4 },
    { "ucs-4le",   "\xFF\xFE\x00\x00",  4 },
    { "UTF-8",     "\xEF\xBB\xBF",      3 },
    { "utf-16",    "\xFE\xFF",          2 },
    { "utf-16le",  "\xFF\xFE",          2 },
    { NULL,        NULL,                0 }
  };
  for (size_t i = 0; patterns[i].name; ++i) {
    const pattern_t& item = patterns[i];
    if (len >= item.pattern_len &&
        memcmp(buffer, item.pattern, item.pattern_len) == 0) {
      return item.name;
    }
  }
  return NULL;
}

static const char* check_freq_dbyte(uint16_t dbyte)
{
  for (size_t i = 0;
       i < sizeof freq_analysis_data / sizeof(freq_analysis_data_t);
       ++i) {
    if (dbyte == freq_analysis_data[i].dbyte) {
      // if (verbose) {
      //   printf("Found frequent double-byte %.4x\n", dbyte);
      // }
      return freq_analysis_data[i].enc;
    }
  }
  return NULL;
}

static const char* search_freq_dbytes(const char_count_vec_t& dbyte_char_cnt)
{
  size_t max_comp_idx = 10;
  if (max_comp_idx > dbyte_char_cnt.size()) {
    max_comp_idx = dbyte_char_cnt.size();
  }
  for (size_t i = 0; i < max_comp_idx; ++i) {
    if (const char* enc = check_freq_dbyte(dbyte_char_cnt[i].first)) {
      return enc;
    }
  }
  return NULL;
}

const char* tellenc(const unsigned char* const buffer, const size_t len)
{
  if (len == 0) {
    return "unknown";
  }
  
  if (const char* result = check_ucs_bom(buffer, len)) {
    return result;
  }
  
  char_count_t sbyte_char_cnt[MAX_CHAR];
  char_count_map_t dbyte_char_cnt_map;
  init_sbyte_char_count(sbyte_char_cnt);
  
  unsigned char ch;
  int last_ch = EOF;
  int utf8_state = UTF8_1;
  for (size_t i = 0; i < len; ++i) {
    ch = buffer[i];
    sbyte_char_cnt[ch].second++;
    
    // Check for binary data (including UTF-16/32)
    if (is_non_text(ch)) {
      if (!is_binary && !(ch == DOS_EOF && i == len - 1)) {
        is_binary = true;
      }
      if (ch == NUL) {
        // Count for NULs in even- and odd-number bytes
        nul_count_byte[i & 1]++;
        if (i & 1) {
          if (buffer[i - 1] == NUL) {
            // Count for NULs in even- and odd-number words
            nul_count_word[(i / 2) & 1]++;
          }
        }
      }
    }
    
    // Check for UTF-8 validity
    if (is_valid_utf8) {
      switch (utf8_char_table[ch]) {
      case UTF8_INVALID:
        is_valid_utf8 = false;
        break;
      case UTF8_1:
        if (utf8_state != UTF8_1) {
          is_valid_utf8 = false;
        }
        break;
      case UTF8_2:
        if (utf8_state != UTF8_1) {
          is_valid_utf8 = false;
        } else {
          utf8_state = UTF8_2;
        }
        break;
      case UTF8_3:
        if (utf8_state != UTF8_1) {
          is_valid_utf8 = false;
        } else {
          utf8_state = UTF8_3;
        }
        break;
      case UTF8_4:
        if (utf8_state != UTF8_1) {
          is_valid_utf8 = false;
        } else {
          utf8_state = UTF8_4;
        }
        break;
      case UTF8_TAIL:
        if (utf8_state > UTF8_1) {
          utf8_state--;
        } else {
          is_valid_utf8 = false;
        }
        break;
      }
    }
    
    // Check whether non-Latin1 characters appear
    if (is_valid_latin1) {
      if (ch >= 0x80 && ch < 0xa0) {
        is_valid_latin1 = false;
      }
    }
    
    // Construct double-bytes and count
    if (last_ch != EOF) {
      uint16_t dbyte_char = (last_ch << 8) + ch;
      dbyte_char_cnt_map[dbyte_char]++;
      dbyte_cnt++;
      if (last_ch > 0xa0 && ch > 0xa0) {
        dbyte_hihi_cnt++;
      }
      last_ch = EOF;
    } else if (ch >= 0x80) {
      last_ch = ch;
    }
  }
  
  // Get the character counts in descending order
  sort(sbyte_char_cnt, sbyte_char_cnt + MAX_CHAR, greater_char_count());
  
  // Get the double-byte counts in descending order
  char_count_vec_t dbyte_char_cnt;
  for (char_count_map_t::iterator it = dbyte_char_cnt_map.begin();
       it != dbyte_char_cnt_map.end(); ++it) {
    dbyte_char_cnt.push_back(*it);
  }
  sort(dbyte_char_cnt.begin(),
       dbyte_char_cnt.end(),
       greater_char_count());
  
  // if (verbose) {
  //   print_sbyte_char_cnt(sbyte_char_cnt);
  //   print_dbyte_char_cnt(dbyte_char_cnt);
  //   printf("%u characters\n", (unsigned)len);
  //   printf("%u double-byte characters\n", dbyte_cnt);
  //   printf("%u double-byte hi-hi characters\n", dbyte_hihi_cnt);
  //   printf("%u unique double-byte characters\n",
  //          (unsigned)dbyte_char_cnt.size());
  // }
  
  if (!is_valid_utf8 && is_binary) {
    // Heuristics for UTF-16/32
    if        (nul_count_byte[EVEN] > 4 &&
               (nul_count_byte[ODD] == 0 ||
               nul_count_byte[EVEN] / nul_count_byte[ODD] > 20)) {
      return "utf-16";
    } else if (nul_count_byte[ODD] > 4 &&
      (nul_count_byte[EVEN] == 0 ||
      nul_count_byte[ODD] / nul_count_byte[EVEN] > 20)) {
      return "utf-16le";
    } else if (nul_count_word[EVEN] > 4 &&
      (nul_count_word[ODD] == 0 ||
      nul_count_word[EVEN] / nul_count_word[ODD] > 20)) {
      return "ucs-4";   // utf-32 is not a built-in encoding for Vim
    } else if (nul_count_word[ODD] > 4 &&
      (nul_count_word[EVEN] == 0 ||
      nul_count_word[ODD] / nul_count_word[EVEN] > 20)) {
      return "ucs-4le"; // utf-32le is not a built-in encoding for Vim
    } else {
      return "binary";
    }
  } else if (dbyte_cnt == 0) {
    // No characters outside the scope of ASCII
    return "ascii";
  } else if (is_valid_utf8) {
    // Only valid UTF-8 sequences
    return "UTF-8";
  } else if (const char* enc = search_freq_dbytes(dbyte_char_cnt)) {
    return enc;
  } else if (dbyte_hihi_cnt * 100 / dbyte_cnt < 5) {
    // Mostly a low-byte follows a high-byte
    return "windows-1252";
  }
  return NULL;
}

const char* tellenc_simplify(const char* const buffer, const size_t len)
{
  const char* enc = tellenc((const unsigned char*)buffer, len);
  if (enc) {
    if (strcmp(enc, "windows-1252") == 0 && is_valid_latin1) {
      // Latin1 is subset of Windows-1252
      return "latin1";
    } else if (strcmp(enc, "gbk") == 0 && dbyte_hihi_cnt == dbyte_cnt) {
      // Special case for GB2312: no high-byte followed by a low-byte
      return "gb2312";
    }
  }
  return enc;
}


//' @title Files encoding detection
//' @description The function detect the encoding of input files.
//' @param file A file path.
//' @return The encoding of file
//' @author Wu Yongwei, Qin wenfeng
//' @references \url{https://github.com/adah1972/tellenc}
//' @export
// [[Rcpp::export]]
CharacterVector file_coding(CharacterVector file){
  const char *const filename = file[0];
  FILE *fp = fopen(filename, "rb");
  if (fp == NULL)
  {
    stop("Cannot open file");
  }
  
  char buffer[TELLENC_BUFFER_SIZE];
  size_t len;
  len = fread(buffer, 1, sizeof buffer, fp);
  fclose(fp);
  
  init_utf8_char_table();
  if (const char *enc = tellenc_simplify(buffer, len))
  {
    return CharacterVector::create(enc);
  }
  else
  {
    Rcpp::warning("filcoding(): can not detect encoding, so use UTF-8 as default.");
    return  CharacterVector::create("UTF-8");
  }
}