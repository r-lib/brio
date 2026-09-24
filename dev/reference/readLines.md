# Read text lines from a file

This is a drop in replacement for
[`base::readLines()`](https://rdrr.io/r/base/readLines.html) with
restricted functionality. Compared to
[`base::readLines()`](https://rdrr.io/r/base/readLines.html) it:

- Only works with file paths, not connections.

- Assumes the files are always UTF-8 encoded.

- Does not warn or skip embedded nulls, they will likely crash R.

- Does not warn if the file is missing the end of line character.

- The arguments `ok`, `warn`, `encoding` and `skipNul` are ignored, with
  a warning.

## Usage

``` r
readLines(con, n = -1, ok, warn, encoding, skipNul)
```

## Arguments

- con:

  A character string of the path to a file. Throws an error if a
  connection object is passed.

- n:

  integer. The number of lines to read. A negative number means read all
  the lines in the file.

- ok:

  Ignored, with a warning.

- warn:

  Ignored, with a warning.

- encoding:

  Ignored, with a warning.

- skipNul:

  Ignored, with a warning.

## Value

A UTF-8 encoded character vector of the lines in the file.

## See also

[`writeLines()`](https://brio.r-lib.org/dev/reference/writeLines.md)

## Examples

``` r
authors_file <- file.path(R.home("doc"), "AUTHORS")
data <- readLines(authors_file)

# Trying to use connections throws an error
con <- file(authors_file)
try(readLines(con))
#> Error : Only file paths are supported by brio::readLines()
close(con)

# Trying to use unsupported args throws a warning
data <- readLines(authors_file, encoding = "UTF-16")
#> Warning: `encoding` is ignored by brio::readLines()
```
