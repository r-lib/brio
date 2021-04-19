#include <Rinternals.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "brio.h"

SEXP brio_write_lines(SEXP text, SEXP path, SEXP eol) {
  FILE* fp;

  if ((fp = open_with_widechar_on_windows(STRING_ELT(path, 0), "wb")) == NULL) {
    error("Could not open file: %s", Rf_translateChar(STRING_ELT(path, 0)));
  }

  SEXP eol_e = STRING_ELT(eol, 0);
  size_t eol_len = xlength(eol_e);
  const char* eol_c = CHAR(eol_e);

  R_xlen_t len = xlength(text);

  for (R_xlen_t i = 0; i < len; ++i) {
    SEXP elt = STRING_ELT(text, i);
    R_xlen_t elt_size = xlength(elt);

    const char* cur = CHAR(elt);
    const char* prev = cur;
    while ((cur = strchr(prev, '\n')) != NULL) {
      size_t len = cur - prev;
      if (len > 1 && (cur - 1)[0] == '\r') {
        --len;
      }
      fwrite(prev, 1, len, fp);
      fwrite(eol_c, 1, eol_len, fp);
      prev = cur + 1;
    }
    size_t len = elt_size - (prev - CHAR(elt));
    fwrite(prev, 1, len, fp);
    fwrite(eol_c, 1, eol_len, fp);
  }

  fclose(fp);

  return text;
}
