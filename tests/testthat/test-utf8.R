test_that("UTF-8 file names", {
  skip_on_cran()
  tmp <- tempfile()
  on.exit(unlink(tmp, recursive = TRUE), add = TRUE)
  dir.create(tmp)

  str <- "xx\xfcxx"
  Encoding(str) <- "latin1"

  normalizePath(str, mustWork = FALSE)

  path <- file.path(tmp, str)
  Encoding(path) <- "latin1"

  write_lines(str, path)
  expect_true(file.exists(path))
  str2 <- read_lines(path)
  expect_identical(
    charToRaw(enc2utf8(str2)),
    charToRaw(str2)
  )
})
