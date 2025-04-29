read_file_raw <- function(file) {
  readBin(file, file.info(file)$size, what = "raw")
}

test_that("write_file errors on invalid inputs", {
  tmp <- tempfile()
  on.exit(unlink(tmp))

  expect_snapshot(error = TRUE, {
    write_file(c("foo", "bar"), tmp)
    write_file("foo", c("bar", tmp))
  })
})

test_that("write_file works", {
  tmp <- tempfile()
  on.exit(unlink(tmp))

  write_file(character(), tmp)
  expect_equal(read_file_raw(tmp), charToRaw(""))

  write_file("", tmp)
  expect_equal(read_file_raw(tmp), charToRaw(""))

  write_file(c("foo"), tmp)
  expect_equal(read_file_raw(tmp), charToRaw("foo"))

  write_file(c("foo\n"), tmp)
  expect_equal(read_file_raw(tmp), charToRaw("foo\n"))

  write_file(c("foo\r\n"), tmp)
  expect_equal(read_file_raw(tmp), charToRaw("foo\r\n"))
})
