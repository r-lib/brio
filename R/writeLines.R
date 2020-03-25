#' Write lines to a file
#'
#' This is a drop in replacement for [base::writeLines()] with restricted
#' functionality. Compared to [base::writeLines()] it:
#' - Only works with file paths, not connections.
#' - Uses [enc2utf8()] to convert `text()` to UTF-8 before writing.
#' - Uses `sep` unconditionally as the line ending, regardless of platform.
#' - The `useBytes` argument is ignored, with a warning.
#' @inheritParams write_lines
#' @inheritParams readLines
#' @param sep The end of line characters to use between lines.
#' @param useBytes Ignored, with a warning.
#' @return The UTF-8 encoded input text (invisibly).
#' @seealso [readLines()]
#' @export
#' @examples
#' tf <- tempfile()
#'
#' writeLines(rownames(mtcars), tf)
#'
#' # Trying to use connections throws an error
#' con <- file(tf)
#' try(writeLines(con))
#' close(con)
#'
#' # Trying to use unsupported args throws a warning
#' writeLines(rownames(mtcars), tf, useBytes = TRUE)
#'
#' unlink(tf)
writeLines <- function(text, con, sep = "\n", useBytes) {
  if (!is.character(con)) {
    stop("Only file paths are supported by brio::writeLines()", call. = FALSE)
  }
  if (!missing(useBytes)) {
    warning("`useBytes` is ignored by brio::writeLines()", immediate. = TRUE, call. = FALSE)
  }
  write_lines(text, path = con, eol = sep)
}
