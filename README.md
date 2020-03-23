
<!-- README.md is generated from README.Rmd. Please edit that file -->

# brio - Basic R Input Output

<!-- badges: start -->

[![Codecov test
coverage](https://codecov.io/gh/r-lib/brio/branch/master/graph/badge.svg)](https://codecov.io/gh/r-lib/brio?branch=master)
[![R build
status](https://github.com/r-lib/brio/workflows/R-CMD-check/badge.svg)](https://github.com/r-lib/brio/actions)
<!-- badges: end -->

Functions to handle basic input output, these functions always read and
write UTF-8 files and provide more explicit control over line endings.

## Reading files

``` r
library(brio)
write_lines(c("abc", "123"), "my-file")

# Write with windows newlines
write_lines(c("abc", "123"), "my-file-2", eol = "\r\n")

file_line_ending("my-file")
#> [1] "\n"

file_line_ending("my-file-2")
#> [1] "\r\n"

read_lines("my-file")
#> [1] "abc" "123"

unlink(c("my-file", "my-file-2"))
```

## Benchmarks

Speed is not necessarily a goal of brio, but it does end up being a nice
side effect.

``` r
gen_random <- function(characters, num_lines, min, max) {
  line_lengths <- sample.int(max - min, num_lines, replace = TRUE) + min
  vapply(line_lengths, function(len) paste(sample(characters, len, replace = TRUE), collapse = ""), character(1))
}

# generate 1000 random lines between 100-1000 characters long
data <- gen_random(letters, 1000, min = 100, max = 1000)
```

## Writing

Write speeds are basically the same regardless of method, though brio
does avoid any extra memory allocations.

``` r
bench::mark(
  brio::write_lines(data, "benchmark"),
  readr::write_lines(data, "benchmark"),
  base::writeLines(data, "benchmark"),
  check = FALSE
)
#> # A tibble: 3 x 6
#>   expression                               min median `itr/sec` mem_alloc
#>   <bch:expr>                            <bch:> <bch:>     <dbl> <bch:byt>
#> 1 brio::write_lines(data, "benchmark")  1.06ms 1.24ms      760.        0B
#> 2 readr::write_lines(data, "benchmark") 1.17ms 1.36ms      591.    3.54MB
#> 3 base::writeLines(data, "benchmark")   1.13ms 1.38ms      679.    6.91KB
#> # … with 1 more variable: `gc/sec` <dbl>
```

## Reading

Reading speeds are a decent amount faster with brio, mainly due to
larger block sizes and avoidance of unnecessary copies.

``` r
bench::mark(
  brio::read_lines("benchmark"),
  readr::read_lines("benchmark"),
  base::readLines("benchmark")
)
#> # A tibble: 3 x 6
#>   expression                          min   median `itr/sec` mem_alloc `gc/sec`
#>   <bch:expr>                     <bch:tm> <bch:tm>     <dbl> <bch:byt>    <dbl>
#> 1 brio::read_lines("benchmark")  966.43µs   1.04ms      925.    8.05KB        0
#> 2 readr::read_lines("benchmark")   1.79ms   1.84ms      530.   609.9KB        0
#> 3 base::readLines("benchmark")     4.82ms   4.96ms      200.   31.39KB        0

unlink("benchmark")
```
