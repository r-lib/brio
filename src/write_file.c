#include <Rinternals.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "brio.h"

SEXP brio_write_file(SEXP text, SEXP path) {
  FILE* fp;

  if ((fp = open_with_widechar_on_windows(STRING_ELT(path, 0), "wb")) == NULL) {
    error("Could not open file: %s", Rf_translateChar(STRING_ELT(path, 0)));
  }

  if (xlength(text) == 0) {
    fwrite("", 1, 0, fp);
  } else {
    SEXP elt = STRING_ELT(text, 0);
    R_xlen_t elt_size = xlength(elt);

    fwrite(CHAR(elt), 1, elt_size, fp);
  }

  fclose(fp);

  return text;
}
