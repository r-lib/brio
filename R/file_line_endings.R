#' Retrieve the type of line endings used by a file
#'
#' @inheritParams read_lines
#' @return The line endings used, one of
#'   - '\\n' - if the file uses Unix line endings
#'   - '\\r\\n' - if the file uses Windows line endings
#'   - NA - if it cannot be determined
#' @export
file_line_endings <- function(path) {
  path <- normalizePath(path, mustWork = TRUE)
  .Call(brio_file_line_endings, path)
}
