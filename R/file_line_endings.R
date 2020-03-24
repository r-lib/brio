#' Retrieve the type of line endings used by a file
#'
#' @inheritParams read_lines
#' @return The line endings used, one of
#'   - '\\n' - if the file uses Unix line endings
#'   - '\\r\\n' - if the file uses Windows line endings
#'   - NA - if it cannot be determined
#' @export
#' @examples
#' tf1 <- tempfile()
#' tf2 <- tempfile()
#' write_lines("foo", tf1, eol = "\n")
#' write_lines("bar", tf2, eol = "\r\n")
#'
#' file_line_endings(tf1)
#' file_line_endings(tf2)
#'
#' unlink(c(tf1, tf2))
file_line_endings <- function(path) {
  path <- normalizePath(path, mustWork = TRUE)
  .Call(brio_file_line_endings, path)
}
