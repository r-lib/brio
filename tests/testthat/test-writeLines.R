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
