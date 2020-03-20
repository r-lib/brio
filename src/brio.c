#include <stdio.h>

#ifdef _WIN32
#include <Rinternals.h>
#include <windows.h>
#endif

// This is needed to support wide character paths on windows
FILE* open_with_widechar_on_windows(const char* txt, const char* mode) {
  FILE* out;
#ifdef _WIN32
  wchar_t* buf;
  size_t len = MultiByteToWideChar(CP_UTF8, 0, txt, -1, NULL, 0);
  if (len <= 0) {
    error("Cannot convert file to Unicode: %s", txt);
  }
  buf = (wchar_t*)R_alloc(len, sizeof(wchar_t));
  if (buf == NULL) {
    error("Could not allocate buffer of size: %ll", len);
  }

  MultiByteToWideChar(CP_UTF8, 0, txt, -1, buf, len);
  if (strncmp(mode, "rb", 2) == 0) {
    out = _wfopen(buf, L"rb");
  } else if (strncmp(mode, "wb", 2) == 0) {
    out = _wfopen(buf, L"wb");
  }
#else
  out = fopen(txt, mode);
#endif

  return out;
}
