#include <Rinternals.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "brio.h"

SEXP brio_read_file(SEXP path) {
  const char* path_c = CHAR(STRING_ELT(path, 0));

  FILE* fp;

  if ((fp = open_with_widechar_on_windows(path_c, "rb")) == NULL) {
    error("Could not open file: %s", path_c);
  }

  fseek(fp, 0, SEEK_END);       // seek to end of file
  size_t file_size = ftell(fp); // get current file pointer
  rewind(fp);

  if (file_size == 0) {
    fclose(fp);
    return allocVector(STRSXP, 0);
  }

  char* read_buf;

  read_buf = (char*)malloc(file_size + 1);
  read_buf[file_size] = '\0';

  if ((fread(read_buf, 1, file_size, fp)) <= 0) {
    fclose(fp);
    error("Error reading file: %s", path_c);
  };

  fclose(fp);
  SEXP ans;
  PROTECT(ans = allocVector(STRSXP, 1));
  SET_STRING_ELT(ans, 0, mkCharLenCE(read_buf, file_size, CE_UTF8));
  free(read_buf);
  UNPROTECT(1);

  return ans;
}
