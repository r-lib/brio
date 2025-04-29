test_that("writeLines works", {
  tmp <- tempfile()
  on.exit(unlink(tmp))

  # Errors with connections
  con <- file(tmp)
  expect_snapshot(error = TRUE, writeLines("foo\nbar\n", con))
  close(con)

  # Warns if you use useBytes
  expect_warning(writeLines("foo\nbar\n", tmp, useBytes = TRUE), "is ignored")
})
