#' Write lines to a file
#'
#' The text is converted to UTF-8 encoding before writing.
#' @param text A character vector to write
#' @param path A character string giving the file path to write to.
#' @param eol The end of line characters to use between lines.
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
