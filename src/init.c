#include <R.h>
#include <R_ext/Rdynload.h>
#include <Rinternals.h>
#include <stdlib.h> // for NULL

/* .Call calls */
extern SEXP brio_read_lines(SEXP, SEXP);
extern SEXP brio_write_lines(SEXP, SEXP, SEXP);
extern SEXP brio_file_line_ending(SEXP);

static const R_CallMethodDef CallEntries[] = {
    {"brio_read_lines", (DL_FUNC)&brio_read_lines, 2},
    {"brio_write_lines", (DL_FUNC)&brio_write_lines, 3},
    {"brio_file_line_ending", (DL_FUNC)&brio_file_line_ending, 1},

    {NULL, NULL, 0}};

void R_init_brio(DllInfo* dll) {
  R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
  R_useDynamicSymbols(dll, FALSE);
}
