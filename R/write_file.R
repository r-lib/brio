#' Write data to a file
#'
#' This function differs from [write_lines()]` in that it writes the data in
#' `text` directly, without any checking or adding any newlines.
#'
#' @param text A character vector of length 1 with data to write
#' @param path A character string giving the file path to write to.
#' @return The UTF-8 encoded input text (invisibly).
#' @export
#' @examples
#' tf <- tempfile()
#'
#' write_file("some data\n", tf)
#'
#' unlink(tf)
write_file <- function(text, path) {
  text <- as.character(text)

  if (length(text) > 1) {
    stop("`text` cannot have more than one element", call. = FALSE)
  }

  if (length(path) != 1) {
    stop("`path` must be a single element", call. = FALSE)
  }

  text <- enc2utf8(text)
  path <- normalizePath(path, mustWork = FALSE)

  invisible(.Call(brio_write_file, text, path))
}
