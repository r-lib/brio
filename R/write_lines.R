#' Write lines to a file
#'
#' The text is converted to UTF-8 encoding before writing.
#' @param text A character vector to write
#' @param path A character string giving the file path to write to.
#' @param eol The end of line character to use between lines.
#' @return The UTF-8 encoded input text (invisibly).
#' @export
#' @examples
#' tf <- tempfile()
#'
#' write_lines(rownames(mtcars), tf)
#'
#' unlink(tf)
write_lines <- function(text, path, eol = "\n") {
  text <- as.character(text)
  text <- enc2utf8(text)
  path <- normalizePath(path, mustWork = FALSE)
  invisible(.Call(brio_write_lines, text, path, eol))
}

#' Write lines to a file
#'
#' This is a drop in replacement for [base::writeLines()] with restricted
#' functionality. Compared to [base::writeLines()] it:
#' - Only works with file paths, not connections.
#' - Uses [enc2utf8()] to convert `text()` to UTF-8 before writing.
#' - Uses `sep` uncoditionally as the line ending, regardless of platform.
#' - The `useBytes` argument is ignored, with a warning.
#' @export
writeLines <- function(text, con, sep = "\n", useBytes) {
  if (!is.character(con)) {
    stop("Only file paths are supported by brio::writeLines()", call. = FALSE)
  }
  if (!missing(useBytes)) {
    warning("`useBytes` is ignored by brio::writeLines()", immediate. = TRUE, call. = FALSE)
  }
  write_lines(text, path = con, eol = sep)
}
