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
