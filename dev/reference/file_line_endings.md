# Retrieve the type of line endings used by a file

Retrieve the type of line endings used by a file

## Usage

``` r
file_line_endings(path)
```

## Arguments

- path:

  A character string of the path to the file to read.

## Value

The line endings used, one of

- '\n' - if the file uses Unix line endings

- '\r\n' - if the file uses Windows line endings

- NA - if it cannot be determined

## Examples

``` r
tf1 <- tempfile()
tf2 <- tempfile()
write_lines("foo", tf1, eol = "\n")
write_lines("bar", tf2, eol = "\r\n")

file_line_endings(tf1)
#> [1] "\n"
file_line_endings(tf2)
#> [1] "\r\n"

unlink(c(tf1, tf2))
```
