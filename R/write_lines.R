#' Write lines to a file
#'
#' The text is converted to UTF-8 encoding before writing.
#'
#' The files are opened in binary mode, so they always use exactly the string
#' given in `eol` as the line separator.
#'
#' To write a file with windows line endings use `write_lines(eol = "\r\n")`
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
#' # Write with Windows style line endings
#' write_lines(rownames(mtcars), tf, eol = "\r\n")
#'
#' unlink(tf)
write_lines <- function(text, path, eol = "\n") {
  if (length(path) != 1) {
    stop("`path` must be a single element", call. = FALSE)
  }

  text <- as.character(text)
  text <- enc2utf8(text)
  path <- normalizePath(path, mustWork = FALSE)

  invisible(.Call(brio_write_lines, text, path, eol))
}
