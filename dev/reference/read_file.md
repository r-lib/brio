# Read an entire file

`read_file()` reads an entire file into a single character vector.
`read_file_raw()` reads an entire file into a raw vector.

## Usage

``` r
read_file(path)

read_file_raw(path)
```

## Arguments

- path:

  A character string of the path to the file to read.

## Value

- `read_file()`: A length 1 character vector.

- `read_file_raw()`: A raw vector.

## Details

`read_file()` assumes the file has a UTF-8 encoding.

## Examples

``` r
authors_file <- file.path(R.home("doc"), "AUTHORS")
data <- read_file(authors_file)
data_raw <- read_file_raw(authors_file)
identical(data, rawToChar(data_raw))
#> [1] TRUE
```
