
<!-- README.md is generated from README.Rmd. Please edit that file -->

# brio - Basic R Input Output

<!-- badges: start -->

[![Codecov test
coverage](https://codecov.io/gh/r-lib/brio/branch/master/graph/badge.svg)](https://app.codecov.io/gh/r-lib/brio?branch=master)
[![R build
status](https://github.com/r-lib/brio/workflows/R-CMD-check/badge.svg)](https://github.com/r-lib/brio/actions)
<!-- badges: end -->

Functions to handle basic input output, these functions always read and
write UTF-8 files and provide more explicit control over line endings.

## Reading files

``` r
library(brio)
#> 
#> Attaching package: 'brio'
#> The following objects are masked from 'package:base':
#> 
#>     readLines, writeLines
write_lines(c("abc", "123"), "my-file")

# Write with windows newlines
write_lines(c("abc", "123"), "my-file-2", eol = "\r\n")

file_line_endings("my-file")
#> [1] "\n"

file_line_endings("my-file-2")
#> [1] "\r\n"

read_lines("my-file")
#> [1] "abc" "123"

unlink(c("my-file", "my-file-2"))
```

## Drop-ins

brio also has `readLines()` and `writeLines()` functions drop-in
replacements for `base::readLines()` and `base::writeLines()`. These
functions are thin wrappers around `brio::read_lines()` and
`brio::write_lines()`, with deliberately fewer features than the base
equivalents. If you want to convert a package to using brio you can add
the following line and re-document.

``` r
#' @importFrom brio readLines writeLines
```

## Benchmarks

Speed is not necessarily a goal of brio, but it does end up being a nice
side effect.

``` r
gen_random <- function(characters, num_lines, min, max) {
  line_lengths <- sample.int(max - min, num_lines, replace = TRUE) + min
  vapply(line_lengths, function(len) paste(sample(characters, len, replace = TRUE), collapse = ""), character(1))
}

set.seed(42)

# generate 1000 random lines between 100-1000 characters long
data <- gen_random(letters, 1000, min = 100, max = 1000)

brio::write_lines(data, "benchmark")
```

### Reading

Reading speeds are a decent amount faster with brio, mainly due to
larger block sizes and avoidance of extra copies.

``` r
bench::mark(
  brio::read_lines("benchmark"),
  readr::read_lines("benchmark"),
  base::readLines("benchmark")
)
#> # A tibble: 3 × 6
#>   expression                          min   median `itr/sec` mem_alloc `gc/sec`
#>   <bch:expr>                     <bch:tm> <bch:tm>     <dbl> <bch:byt>    <dbl>
#> 1 brio::read_lines("benchmark")  676.56µs 694.67µs     1382.    8.05KB     0   
#> 2 readr::read_lines("benchmark")   3.87ms   4.19ms      235.     7.2MB     8.70
#> 3 base::readLines("benchmark")     3.68ms   3.92ms      250.   31.39KB     0
```

### Writing

Write speeds are basically the same regardless of method, though brio
does avoid some extra memory allocations.

``` r
bench::mark(
  brio::write_lines(data, "benchmark"),
  readr::write_lines(data, "benchmark"),
  base::writeLines(data, "benchmark"),
  check = FALSE
)
#> # A tibble: 3 × 6
#>   expression                                 min   median `itr/sec` mem_alloc
#>   <bch:expr>                            <bch:tm> <bch:tm>     <dbl> <bch:byt>
#> 1 brio::write_lines(data, "benchmark")   833.8µs    1.3ms     751.         0B
#> 2 readr::write_lines(data, "benchmark")  11.86ms     13ms      76.5     195KB
#> 3 base::writeLines(data, "benchmark")     1.07ms   1.52ms     636.         0B
#> # … with 1 more variable: gc/sec <dbl>

unlink("benchmark")
```
