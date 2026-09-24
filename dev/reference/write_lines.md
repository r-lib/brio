# Write lines to a file

The text is converted to UTF-8 encoding before writing.

## Usage

``` r
write_lines(text, path, eol = "\n")
```

## Arguments

- text:

  A character vector to write

- path:

  A character string giving the file path to write to.

- eol:

  The end of line characters to use between lines.

## Value

The UTF-8 encoded input text (invisibly).

## Details

The files are opened in binary mode, so they always use exactly the
string given in `eol` as the line separator.

To write a file with windows line endings use
`write_lines(eol = "\r\n")`

## Examples

``` r
tf <- tempfile()

write_lines(rownames(mtcars), tf)

# Write with Windows style line endings
write_lines(rownames(mtcars), tf, eol = "\r\n")

unlink(tf)
```
