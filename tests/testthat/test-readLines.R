test_that("readLines works", {
  tmp <- tempfile()
  on.exit(unlink(tmp))

  writeLines("foo\nbar\n", tmp)

  # Errors with connections
  con <- file(tmp)
  expect_snapshot(error = TRUE, readLines(con))
  close(con)

  # Warns if you use ok, warn, encoding or skipNul
  expect_warning(readLines(tmp, ok = TRUE), "is ignored")
  expect_warning(readLines(tmp, warn = TRUE), "is ignored")
  expect_warning(readLines(tmp, encoding = "Latin-1"), "is ignored")
  expect_warning(readLines(tmp, skipNul = TRUE), "is ignored")
})
