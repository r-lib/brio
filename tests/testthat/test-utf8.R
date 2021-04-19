
test_that("UTF-8 file names", {
  skip_on_cran()
  tmp <- tempfile()
  on.exit(unlink(tmp, recursive = TRUE), add = TRUE)
  dir.create(tmp)
  str <- "xx\xfcxx"
  Encoding(str) <- "latin1"
  write_lines(str, file.path(tmp, str))
  expect_true(file.exists(file.path(tmp, str)))
  str2 <- read_lines(file.path(tmp, str))
  expect_identical(
    charToRaw(enc2utf8(str2)),
    charToRaw(str2)
  )
})
