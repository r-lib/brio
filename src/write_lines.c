#include <Rinternals.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "brio.h"

SEXP brio_write_lines(SEXP text, SEXP path, SEXP eol) {
  FILE* fp;

  const char* path_c = CHAR(STRING_ELT(path, 0));

  if ((fp = open_with_widechar_on_windows(path_c, "wb")) == NULL) {
    error("Could not open file: %s", path_c);
  }

  SEXP eol_e = STRING_ELT(eol, 0);
  size_t eol_len = xlength(eol_e);
  const char* eol_c = CHAR(eol_e);

  R_xlen_t len = xlength(text);

  for (R_xlen_t i = 0; i < len; ++i) {
    SEXP elt = STRING_ELT(text, i);
    R_xlen_t elt_size = xlength(elt);
    fwrite(CHAR(elt), 1, elt_size, fp);
    fwrite(eol_c, 1, eol_len, fp);
  }

  fclose(fp);

  return text;
}
