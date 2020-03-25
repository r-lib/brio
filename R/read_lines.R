#' Read text lines from a file
#'
#' The file is assumed to be UTF-8 and the resulting text has its encoding set
#' as such.
#' @param path A character string of the path to the file to read.
#' @param n integer. The number of lines to read. A negative number means read
#'  all the lines in the file.
#' @return A UTF-8 encoded character vector of the lines in the file.
#' @export
#' @examples
#' authors_file <- file.path(R.home("doc"), "AUTHORS")
#' data <- read_lines(authors_file)
read_lines <- function(path, n = -1) {
  path <- normalizePath(path, mustWork = TRUE)
  n <- as.integer(n)
  .Call(brio_read_lines, path, n)
}
