#include <Rinternals.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "brio.h"

SEXP brio_read_file_raw(SEXP path) {
  FILE* fp;

  if ((fp = open_with_widechar_on_windows(STRING_ELT(path, 0), "rb")) == NULL) {
    error("Could not open file: %s", Rf_translateChar(STRING_ELT(path, 0)));
  }

  fseek(fp, 0, SEEK_END);       // seek to end of file
  size_t file_size = ftell(fp); // get current file pointer
  rewind(fp);

  if (file_size == 0) {
    fclose(fp);
    return allocVector(RAWSXP, 0);
  }

  char* read_buf;

  read_buf = (char*)malloc(file_size + 1);
  if (!read_buf) {
    fclose(fp);
    error("Allocation of size %i failed", file_size + 1);
  }
  read_buf[file_size] = '\0';

  if ((fread(read_buf, 1, file_size, fp)) != file_size) {
    fclose(fp);
    error("Error reading file: %s", Rf_translateChar(STRING_ELT(path, 0)));
  }

  fclose(fp);

  SEXP ans;
  PROTECT(ans = allocVector(RAWSXP, file_size));
  memcpy(RAW(ans), read_buf, file_size);
  free(read_buf);
  UNPROTECT(1);

  return ans;
}
