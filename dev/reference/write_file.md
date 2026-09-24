# Write data to a file

This function differs from
[`write_lines()`](https://brio.r-lib.org/dev/reference/write_lines.md)
in that it writes the data in `text` directly, without any checking or
adding any newlines.

## Usage

``` r
write_file(text, path)
```

## Arguments

- text:

  A character vector of length 1 with data to write.

- path:

  A character string giving the file path to write to.

## Value

The UTF-8 encoded input text (invisibly).

## Examples

``` r
tf <- tempfile()

write_file("some data\n", tf)

unlink(tf)
```
