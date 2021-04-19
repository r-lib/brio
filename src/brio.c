#include "brio.h"
#include <stdio.h>

#ifdef _WIN32
#include <windows.h>
#endif

// This is needed to support wide character paths on windows
FILE* open_with_widechar_on_windows(SEXP path, const char* mode) {
  FILE* out;
#ifdef _WIN32
  const char* path_c = Rf_translateCharUTF8(path);
  // First convert the mode to the wide equivalent
  // Only usage is 2 characters so max 8 bytes + 2 byte null.
  wchar_t mode_w[10];
  MultiByteToWideChar(CP_UTF8, 0, mode, -1, mode_w, 9);

  // Then convert the path
  wchar_t* buf;
  size_t len = MultiByteToWideChar(CP_UTF8, 0, path_c, -1, NULL, 0);
  if (len <= 0) {
    error("Cannot convert file to Unicode: %s", path_c);
  }
  buf = (wchar_t*)R_alloc(len, sizeof(wchar_t));
  if (buf == NULL) {
    error("Could not allocate buffer of size: %ll", len);
  }

  MultiByteToWideChar(CP_UTF8, 0, path_c, -1, buf, len);
  out = _wfopen(buf, mode_w);
#else
  out = fopen(Rf_translateChar(path), mode);
#endif

  return out;
}
