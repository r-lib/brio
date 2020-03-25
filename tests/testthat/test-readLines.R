test_that("readLines works", {
  tmp <- tempfile()
  on.exit(unlink(tmp))

  writeLines("foo\nbar\n", tmp)

  # Errors with connections
  con <- file(tmp)
  expect_error(readLines(con), "Only file paths are supported")
  close(con)

  # Warns if you use ok, warn, encoding or skipNul
  expect_warning(readLines(tmp, ok = TRUE), "is ignored")
  expect_warning(readLines(tmp, warn = TRUE), "is ignored")
  expect_warning(readLines(tmp, encoding = "Latin-1"), "is ignored")
  expect_warning(readLines(tmp, skipNul = TRUE), "is ignored")
})
