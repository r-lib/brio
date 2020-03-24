
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

set.seed(42)

# generate 1000 random lines between 100-1000 characters long
data <- gen_random(letters, 1000, min = 100, max = 1000)
```

## Writing

Write speeds are basically the same regardless of method, though brio
does avoid some extra memory allocations.

``` r
bench::mark(
  brio::write_lines(data, "benchmark"),
  readr::write_lines(data, "benchmark"),
  base::writeLines(data, "benchmark"),
  check = FALSE
)
#> # A tibble: 3 x 6
#>   expression                              min median `itr/sec` mem_alloc
#>   <bch:expr>                            <bch> <bch:>     <dbl> <bch:byt>
#> 1 brio::write_lines(data, "benchmark")  792µs 1.16ms      831.        0B
#> 2 readr::write_lines(data, "benchmark")   1ms 1.24ms      780.    2.49KB
#> 3 base::writeLines(data, "benchmark")   921µs 1.34ms      765.        0B
#> # … with 1 more variable: `gc/sec` <dbl>
```

## Reading

Reading speeds are a decent amount faster with brio, mainly due to
larger block sizes and avoidance of extra copies.

``` r
bench::mark(
  brio::read_lines("benchmark"),
  readr::read_lines("benchmark"),
  base::readLines("benchmark")
)
#> # A tibble: 3 x 6
#>   expression                          min   median `itr/sec` mem_alloc
#>   <bch:expr>                     <bch:tm> <bch:tm>     <dbl> <bch:byt>
#> 1 brio::read_lines("benchmark")  685.56µs 718.11µs     1372.    8.05KB
#> 2 readr::read_lines("benchmark")    1.5ms   1.55ms      630.   10.35KB
#> 3 base::readLines("benchmark")     3.53ms   3.67ms      267.   31.39KB
#> # … with 1 more variable: `gc/sec` <dbl>

unlink("benchmark")
```
