#' @rdname read_file
#' @export
read_file_raw <- function(path) {
  path <- normalizePath(path, mustWork = TRUE)
  .Call(brio_read_file_raw, path)
}
