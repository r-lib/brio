test_that("read_lines works on empty files", {

  tmp <- tempfile()
  on.exit(unlink(tmp))

  writeBin(charToRaw(""), tmp)

  expect_equal(read_lines(tmp, 0), character())
  expect_equal(read_lines(tmp), character())
  expect_equal(read_lines(tmp, 1), character())
})

test_that("read_lines works files with no newlines", {

  tmp <- tempfile()
  on.exit(unlink(tmp))

  writeBin(charToRaw("foo"), tmp)

  expect_equal(read_lines(tmp, 0), character())
  expect_equal(read_lines(tmp), "foo")
  expect_equal(read_lines(tmp, 1), "foo")
})

test_that("read_lines works files with only newlines", {

  tmp <- tempfile()
  on.exit(unlink(tmp))

  writeBin(charToRaw("\n"), tmp)

  expect_equal(read_lines(tmp, 0), character())
  expect_equal(read_lines(tmp, 1), "")
  expect_equal(read_lines(tmp), "")
})

test_that("read_lines works files with only windows newlines", {

  tmp <- tempfile()
  on.exit(unlink(tmp))

  writeBin(charToRaw("\r\n"), tmp)

  expect_equal(read_lines(tmp, 0), character())
  expect_equal(read_lines(tmp, 1), "")
  expect_equal(read_lines(tmp), "")
})

test_that("read_lines works with unix line endings", {

  tmp <- tempfile()
  on.exit(unlink(tmp))

  writeBin(charToRaw("foo\nbar\nbaz\n"), tmp)

  expect_equal(read_lines(tmp), c("foo", "bar", "baz"))
  expect_equal(read_lines(tmp, 0), character())
  expect_equal(read_lines(tmp, 1), c("foo"))
})

test_that("read_lines works with unix line endings and no trailing newline", {

  tmp <- tempfile()
  on.exit(unlink(tmp))

  writeBin(charToRaw("foo\nbar\nbaz"), tmp)

  expect_equal(read_lines(tmp), c("foo", "bar", "baz"))
  expect_equal(read_lines(tmp, 0), character())
  expect_equal(read_lines(tmp, 1), c("foo"))
})

test_that("read_lines works with Windows line endings", {

  tmp <- tempfile()
  on.exit(unlink(tmp))

  writeBin(charToRaw("foo\r\nbar\r\nbaz\r\n"), tmp)

  expect_equal(read_lines(tmp), c("foo", "bar", "baz"))
  expect_equal(read_lines(tmp, 0), character())
  expect_equal(read_lines(tmp, 1), c("foo"))
})

test_that("read_lines works with Windows line endings and no trailing newline", {

  tmp <- tempfile()
  on.exit(unlink(tmp))

  writeBin(charToRaw("foo\r\nbar\r\nbaz"), tmp)

  expect_equal(read_lines(tmp), c("foo", "bar", "baz"))
  expect_equal(read_lines(tmp, 0), character())
  expect_equal(read_lines(tmp, 1), c("foo"))
})
