test_that("writeLines works", {
  tmp <- tempfile()
  on.exit(unlink(tmp))

  # Errors with connections
  con <- file(tmp)
  expect_warning(writeLines("foo\nbar\n", con), "Falling back to base::writeLines()")
  close(con)

  # Warns if you use useBytes
  expect_warning(writeLines("foo\nbar\n", tmp, useBytes = TRUE), "is ignored")
})
