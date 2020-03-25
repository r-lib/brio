#include <Rinternals.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "brio.h"

typedef struct {
  char* data;
  size_t size;
  size_t limit;
} str_buf;

void str_buf_set(str_buf* buf, const char* in, size_t in_size) {
  while (buf->size + in_size >= buf->limit) {
    buf->limit *= 2;
    buf->data = realloc(buf->data, buf->limit);
  }

  memcpy(buf->data + buf->size, in, in_size);
  buf->size += in_size;
  buf->data[buf->size] = '\0';
}

SEXP str_sxp_set(SEXP x, int i, SEXP val) {
  R_xlen_t len = Rf_xlength(x);
  if (i >= len) {
    len *= 2;
    x = Rf_lengthgets(x, len);
  }
  SET_STRING_ELT(x, i, val);
  return x;
}

SEXP brio_read_lines(SEXP path, SEXP n) {
  int n_c = INTEGER(n)[0];
  if (n_c == 0) {
    return allocVector(STRSXP, 0);
  }

  const char* path_c = CHAR(STRING_ELT(path, 0));

  FILE* fp;

  if ((fp = open_with_widechar_on_windows(path_c, "rb")) == NULL) {
    error("Could not open file: %s", path_c);
  }

  SEXP out;

  out = allocVector(STRSXP, n_c >= 0 ? n_c : 1024);
  PROTECT_INDEX out_idx;
  PROTECT_WITH_INDEX(out, &out_idx);

  const size_t READ_BUF_SIZE = 1024 * 1024;
  char read_buf[READ_BUF_SIZE];
  R_xlen_t out_num = 0;

  str_buf line;
  line.limit = 1024;
  line.data = (char*)malloc(line.limit);
  line.size = 0;

  size_t read_size = 0;
  while ((read_size = fread(read_buf, 1, READ_BUF_SIZE - 1, fp)) > 0) {
    read_buf[read_size] = '\0';
    // Find the newlines
    const char* prev_newline = read_buf;
    const char* next_newline = read_buf;

    while ((next_newline = strchr(prev_newline, '\n')) != NULL) {
      size_t len = next_newline - prev_newline;

      if (len == 0) {
        if (line.size > 0) {
          if (line.data[line.size - 1] == '\r') {
            --line.size;
            line.data[line.size] = '\0';
          }
        }
      } else {
        if ((next_newline - 1)[0] == '\r') {
          --len;
        }
      }

      str_buf_set(&line, prev_newline, len);

      SEXP str = PROTECT(mkCharLenCE(line.data, line.size, CE_UTF8));
      REPROTECT(out = str_sxp_set(out, out_num++, str), out_idx);
      UNPROTECT(1);

      if (n_c > 0 && out_num >= n_c) {
        fclose(fp);
        UNPROTECT(1);
        return out;
      }

      prev_newline = next_newline + 1;
      line.size = 0;
    }

    size_t len = read_size - (prev_newline - read_buf);
    str_buf_set(&line, prev_newline, len);
  }

  if (line.size > 0) {
    SEXP str = PROTECT(mkCharCE(line.data, CE_UTF8));
    REPROTECT(out = str_sxp_set(out, out_num++, str), out_idx);
    UNPROTECT(1);
  }

  if (out_num < Rf_xlength(out)) {
    SETLENGTH(out, out_num);
    SET_TRUELENGTH(out, out_num);
  }

  fclose(fp);

  UNPROTECT(1);
  return out;
}
