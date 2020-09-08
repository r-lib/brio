#include <Rinternals.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "brio.h"

SEXP brio_file_line_endings(SEXP path) {
  const char* path_c = CHAR(STRING_ELT(path, 0));

  FILE* fp;

  if ((fp = open_with_widechar_on_windows(path_c, "rb")) == NULL) {
    error("Could not open file: %s", path_c);
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
