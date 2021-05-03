#' Write data to a file
#'
#' This function differs from [write_lines()] in that it writes the data in
#' `text` directly, without any checking or adding any newlines.
#'
#' @param raw A raw vector with data to write.
#' @inheritParams write_file
#' @export
#' @examples
#' tf <- tempfile()
#'
#' write_file_raw(as.raw(c(0x66, 0x6f, 0x6f, 0x0, 0x62, 0x61, 0x72)), tf)
#'
#' unlink(tf)
write_file_raw <- function(raw, path) {
  if (!is.raw(raw)) {
    stop("`raw` must be a raw vector", call. = FALSE)
  }

  if (length(path) != 1) {
    stop("`path` must be a single element", call. = FALSE)
  }

  path <- normalizePath(path, mustWork = FALSE)

  invisible(.Call(brio_write_file_raw, raw, path))
}
