test_that("read_file reads empty files", {
  tmp <- tempfile()
  on.exit(unlink(tmp))

  writeBin(charToRaw(""), tmp)

  expect_equal(read_file(tmp), character())
})

works_with <- function(contents) {
  tmp <- tempfile()
  on.exit(unlink(tmp))

  writeBin(charToRaw(contents), tmp)

  expect_equal(read_file(tmp), contents)
}

test_that("read_file reads the entire file", {
  works_with("foo")
  works_with("foo\nbar")
  works_with("foo\nbar\n")
  works_with("foo\r\nbar\r\n")
})
