#' Read an entire file
#'
#' `read_file()` reads an entire file into a single character vector.
#' `read_file_raw()` reads an entire file into a raw vector.
#'
#' `read_file()` assumes the file has a UTF-8 encoding.
#' @inheritParams read_lines
#' @return
#'   - [read_file()]: A length 1 character vector.
#'   - [read_file_raw()]: A raw vector.
#' @export
#' @examples
#' authors_file <- file.path(R.home("doc"), "AUTHORS")
#' data <- read_file(authors_file)
#' data_raw <- read_file_raw(authors_file)
#' identical(data, rawToChar(data_raw))
read_file <- function(path) {
  path <- normalizePath(path, mustWork = TRUE)
  .Call(brio_read_file, path)
}
