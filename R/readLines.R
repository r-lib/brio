#' Read text lines from a file
#'
#' This is a drop in replacement for [base::readLines()] with restricted
#' functionality. Compared to [base::readLines()] it:
#' - Only works with file paths, not connections.
#' - Assumes the files are always UTF-8 encoded.
#' - Does not warn or skip embedded nulls, they will likely crash R.
#' - Does not warn if the file is missing the end of line character.
#' - The arguments `ok`, `warn`, `encoding` and `skipNul` are ignored, with a warning.
#' @param con A character string of the path to a file. Throws an error if a connection object is passed.
#' @inheritParams read_lines
#' @param ok Ignored, with a warning.
#' @param warn Ignored, with a warning.
#' @param encoding Ignored, with a warning.
#' @param skipNul Ignored, with a warning.
#' @export
#' @return A UTF-8 encoded character vector of the lines in the file.
#' @seealso [writeLines()]
#' @examples
#' authors_file <- file.path(R.home("doc"), "AUTHORS")
#' data <- readLines(authors_file)
#'
#' # Trying to use connections throws an error
#' con <- file(authors_file)
#' try(readLines(con))
#' close(con)
#'
#' # Trying to use unsupported args throws a warning
#' data <- readLines(authors_file, encoding = "UTF-16")
readLines <- function(con, n = -1, ok, warn, encoding, skipNul) {
  if (!is.character(con)) {
    stop("Only file paths are supported by brio::readLines()", call. = FALSE)
  }
  if (!missing(ok)) {
    warning("`ok` is ignored by brio::readLines()", immediate. = TRUE, call. = FALSE)
  }
  if (!missing(warn)) {
    warning("`warn` is ignored by brio::readLines()", immediate. = TRUE, call. = FALSE)
  }
  if (!missing(encoding)) {
    warning("`encoding` is ignored by brio::readLines()", immediate. = TRUE, call. = FALSE)
  }
  if (!missing(skipNul)) {
    warning("`skipNul` is ignored by brio::readLines()", immediate. = TRUE, call. = FALSE)
  }
  read_lines(con, n)
}
