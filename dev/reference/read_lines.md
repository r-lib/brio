# Read text lines from a file

The file is assumed to be UTF-8 and the resulting text has its encoding
set as such.

## Usage

``` r
read_lines(path, n = -1)
```

## Arguments

- path:

  A character string of the path to the file to read.

- n:

  integer. The number of lines to read. A negative number means read all
  the lines in the file.

## Value

A UTF-8 encoded character vector of the lines in the file.

## Details

Both '\r\n' and '\n' are treated as a newline.

## Examples

``` r
authors_file <- file.path(R.home("doc"), "AUTHORS")
data <- read_lines(authors_file)
```
