test_that("file_line_ending detects Unix line endings", {
  tmp <- tempfile()
  on.exit(unlink(tmp))

  writeBin(charToRaw("foo\n"), tmp)

  expect_equal(file_line_ending(tmp), "\n")

  writeBin(charToRaw(""), tmp)

  expect_identical(file_line_ending(tmp), NA_character_)
})

test_that("file_line_ending detects Windows line endings", {
  tmp <- tempfile()
  on.exit(unlink(tmp))

  writeBin(charToRaw("foo\r\n"), tmp)

  expect_equal(file_line_ending(tmp), "\r\n")
})
