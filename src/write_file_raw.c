#include <Rinternals.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "brio.h"

SEXP brio_write_file_raw(SEXP raw, SEXP path) {
  FILE* fp;

  if ((fp = open_with_widechar_on_windows(STRING_ELT(path, 0), "wb")) == NULL) {
    error("Could not open file: %s", Rf_translateChar(STRING_ELT(path, 0)));
  }

  if (xlength(raw) == 0) {
    fwrite("", 1, 0, fp);
  } else {
    R_xlen_t size = xlength(raw);

    fwrite(RAW(raw), 1, size, fp);
  }

  fclose(fp);

  return raw;
}
