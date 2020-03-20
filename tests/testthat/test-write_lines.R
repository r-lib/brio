test_that("write_lines works with both unix and windows newlines", {

  tmp <- tempfile()
  on.exit(unlink(tmp))

  write_lines(character(), tmp)
  expect_equal(readBin(tmp, file.info(tmp)$size, what = "raw"), charToRaw(""))

  write_lines("", tmp)
  expect_equal(readBin(tmp, file.info(tmp)$size, what = "raw"), charToRaw("\n"))

  write_lines("", tmp, eol = "\r\n")
  expect_equal(readBin(tmp, file.info(tmp)$size, what = "raw"), charToRaw("\r\n"))

  write_lines(c("foo", "bar"), tmp)
  expect_equal(readBin(tmp, file.info(tmp)$size, what = "raw"), charToRaw("foo\nbar\n"))

  write_lines(c("foo", "bar"), tmp, eol = "\r\n")
  expect_equal(readBin(tmp, file.info(tmp)$size, what = "raw"), charToRaw("foo\r\nbar\r\n"))
})
