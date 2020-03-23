#include <Rinternals.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "brio.h"

SEXP brio_read_lines(SEXP path, SEXP n) {
  int n_c = INTEGER(n)[0];
  const char* path_c = CHAR(STRING_ELT(path, 0));
  if (n_c == 0) {
    return allocVector(STRSXP, 0);
  }

  FILE* fp;

  if ((fp = open_with_widechar_on_windows(path_c, "rb")) == NULL) {
    error("Could not open file: %s", path_c);
  }

  SEXP ans;

  R_xlen_t ans_size = n_c >= 0 ? n_c : 1024;
  PROTECT(ans = allocVector(STRSXP, ans_size));

  const size_t READ_BUF_SIZE = 1024 * 1024;
  char read_buf[READ_BUF_SIZE];
  char* line_buf;
  size_t line_pos = 0;
  size_t line_size = 1024;
  R_xlen_t num_out = 0;

  line_buf = (char*)malloc(line_size);

  size_t read_size = 0;
  while ((read_size = fread(read_buf, 1, READ_BUF_SIZE, fp)) > 0) {
    read_buf[read_size] = '\0';
    // Find the newlines
    const char* prev_result = read_buf;
    const char* result = read_buf;

    while ((result = strchr(prev_result, '\n')) != NULL) {
      size_t len = result - prev_result;

      if (len == 0) {
        if (line_pos > 0) {
          if (line_buf[line_pos - 1] == '\r') {
            line_buf[line_pos - 1] = '\0';
            --line_pos;
          }
        }
      } else {
        if ((result - 1)[0] == '\r') {
          --len;
        }
      }

      if (line_pos + len >= line_size) {
        // The line_buf needs to get bigger
        line_size *= 2;
        line_buf = realloc(line_buf, line_size);
      }

      memcpy(line_buf + line_pos, prev_result, len);
      line_buf[line_pos + len] = '\0';

      if (num_out == ans_size) {
        ans_size *= 2;
        ans = Rf_lengthgets(ans, ans_size);
      }
      SET_STRING_ELT(ans, num_out++, mkCharCE(line_buf, CE_UTF8));

      if (n_c > 0 && num_out >= n_c) {
        fclose(fp);
        UNPROTECT(1);
        return ans;
      }

      prev_result = result + 1;
      line_pos = 0;
    }

    size_t len = read_size - (prev_result - read_buf);
    if (line_pos + len >= line_size) {
      // The line_buf needs to get bigger
      line_size *= 2;
      line_buf = realloc(line_buf, line_size);
    }

    memcpy(line_buf + line_pos, prev_result, len);
    line_pos += len;
    line_buf[line_pos] = '\0';
  }

  if (line_pos > 0) {
    if (num_out == ans_size) {
      ans_size *= 2;
      ans = Rf_lengthgets(ans, ans_size);
    }
    SET_STRING_ELT(ans, num_out++, mkCharCE(line_buf, CE_UTF8));
  }

  if (num_out < ans_size) {
    SETLENGTH(ans, num_out);
    SET_TRUELENGTH(ans, num_out);
  }

  fclose(fp);

  UNPROTECT(1);
  return ans;
}
