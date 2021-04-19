#include <Rinternals.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "brio.h"

SEXP brio_file_line_endings(SEXP path) {
  FILE* fp;

  if ((fp = open_with_widechar_on_windows(STRING_ELT(path, 0), "rb")) == NULL) {
    error("Could not open file: %s", Rf_translateChar(STRING_ELT(path, 0)));
  }

  int c;
  int prev_c = '\0';
  while ((c = fgetc(fp)) != EOF) {
    if (c == '\n') {
      if (prev_c == '\r') {
        fclose(fp);
        return mkString("\r\n");
      } else {
        fclose(fp);
        return mkString("\n");
      }
    }
    prev_c = c;
  }

  fclose(fp);
  return ScalarString(NA_STRING);
}
