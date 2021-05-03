read_file_raw <- function(file) {
  readBin(file, file.info(file)$size, what = "raw")
}

test_that("write_file_raw errors on invalid inputs", {
  tmp <- tempfile()
  on.exit(unlink(tmp))

  expect_error(
    write_file_raw("foo", c("bar", tmp)),
    "must be a raw vector"
  )

  expect_error(
    write_file_raw(charToRaw("foo"), c("bar", tmp)),
    "must be a single element"
  )
})

test_that("write_file_raw works", {
  tmp <- tempfile()
  on.exit(unlink(tmp))

  write_file_raw(raw(), tmp)
  expect_equal(read_file_raw(tmp), charToRaw(""))

  write_file_raw(charToRaw("foo"), tmp)
  expect_equal(read_file_raw(tmp), charToRaw("foo"))

  write_file_raw(charToRaw("foo\n"), tmp)
  expect_equal(read_file_raw(tmp), charToRaw("foo\n"))

  vec <- as.raw(c(0x66, 0x6f, 0x6f, 0x0, 0x62, 0x61, 0x72))
  write_file_raw(vec, tmp)
  expect_equal(read_file_raw(tmp), vec)
})
