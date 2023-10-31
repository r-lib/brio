read_file_raw <- function(file) {
  readBin(file, file.info(file)$size, what = "raw")
}

test_that("write_lines works with both unix and windows newlines", {
  tmp <- tempfile()
  on.exit(unlink(tmp))

  write_lines(character(), tmp)
  expect_equal(read_file_raw(tmp), charToRaw(""))

  write_lines("", tmp)
  expect_equal(read_file_raw(tmp), charToRaw("\n"))

  write_lines("", tmp, eol = "\r\n")
  expect_equal(read_file_raw(tmp), charToRaw("\r\n"))

  write_lines(c("foo", "bar"), tmp)
  expect_equal(read_file_raw(tmp), charToRaw("foo\nbar\n"))

  write_lines(c("foo", "bar"), tmp, eol = "\r\n")
  expect_equal(read_file_raw(tmp), charToRaw("foo\r\nbar\r\n"))
})

test_that("write_lines works with both unix and windows internal newlines", {
  tmp <- tempfile()
  on.exit(unlink(tmp))

  write_lines(character(), tmp)
  write_lines(character(), tmp)
  expect_equal(read_file_raw(tmp), charToRaw(""))

  write_lines("foo\nbar", tmp)
  expect_equal(read_file_raw(tmp), charToRaw("foo\nbar\n"))

  write_lines("foo\r\nbar", tmp)
  expect_equal(read_file_raw(tmp), charToRaw("foo\nbar\n"))

  write_lines("foo\nbar", tmp, eol = "\r\n")
  expect_equal(read_file_raw(tmp), charToRaw("foo\r\nbar\r\n"))

  write_lines("foo\r\nbar", tmp, eol = "\r\n")
  expect_equal(read_file_raw(tmp), charToRaw("foo\r\nbar\r\n"))
})

test_that("writeLines works", {
  tmp <- tempfile()
  on.exit(unlink(tmp))

  # Errors with connections
  con <- file(tmp)
  expect_error(writeLines("foo\nbar\n", con), "Only file paths are supported")
  close(con)

  # Warns if you use useBytes
  expect_warning(writeLines("foo\nbar\n", tmp, useBytes = TRUE), "is ignored")
})

test_that("UTF-8 file names", {
  skip_on_cran()
  tmp <- tempfile()
  on.exit(unlink(tmp, recursive = TRUE), add = TRUE)
  dir.create(tmp)

  str <- "xx\xfcxx"
  Encoding(str) <- "latin1"

  normalizePath(str, mustWork = FALSE)

  path <- file.path(tmp, str)
  Encoding(path) <- "latin1"

  write_lines(str, path)
  expect_true(file.exists(path))
  str2 <- read_lines(path)
  expect_identical(
    charToRaw(enc2utf8(str2)),
    charToRaw(str2)
  )
})
