# Write lines to a file

This is a drop in replacement for
[`base::writeLines()`](https://rdrr.io/r/base/writeLines.html) with
restricted functionality. Compared to
[`base::writeLines()`](https://rdrr.io/r/base/writeLines.html) it:

- Only works with file paths, not connections.

- Uses [`enc2utf8()`](https://rdrr.io/r/base/Encoding.html) to convert
  [`text()`](https://rdrr.io/r/graphics/text.html) to UTF-8 before
  writing.

- Uses `sep` unconditionally as the line ending, regardless of platform.

- The `useBytes` argument is ignored, with a warning.

## Usage

``` r
writeLines(text, con, sep = "\n", useBytes)
```

## Arguments

- text:

  A character vector to write

- con:

  A character string of the path to a file. Throws an error if a
  connection object is passed.

- sep:

  The end of line characters to use between lines.

- useBytes:

  Ignored, with a warning.

## Value

The UTF-8 encoded input text (invisibly).

## See also

[`readLines()`](https://brio.r-lib.org/dev/reference/readLines.md)

## Examples

``` r
tf <- tempfile()

writeLines(rownames(mtcars), tf)

# Trying to use connections throws an error
con <- file(tf)
try(writeLines(con))
#> Error in writeLines(con) : argument "con" is missing, with no default
close(con)

# Trying to use unsupported args throws a warning
writeLines(rownames(mtcars), tf, useBytes = TRUE)
#> Warning: `useBytes` is ignored by brio::writeLines()

unlink(tf)
```
