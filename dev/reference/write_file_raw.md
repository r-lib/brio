# Write data to a file

This function differs from
[`write_lines()`](https://brio.r-lib.org/dev/reference/write_lines.md)
in that it writes the data in `text` directly, without any checking or
adding any newlines.

## Usage

``` r
write_file_raw(raw, path)
```

## Arguments

- raw:

  A raw vector with data to write.

- path:

  A character string giving the file path to write to.

## Examples

``` r
tf <- tempfile()

write_file_raw(as.raw(c(0x66, 0x6f, 0x6f, 0x0, 0x62, 0x61, 0x72)), tf)

unlink(tf)
```
