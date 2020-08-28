#' Write data to a file
#'
#' This function differs from [write_lines()]` in that it.
#' @export
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
