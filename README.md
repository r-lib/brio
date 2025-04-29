
<!-- README.md is generated from README.Rmd. Please edit that file -->

# brio - Basic R Input Output

<!-- badges: start -->

[![R-CMD-check](https://github.com/r-lib/brio/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/r-lib/brio/actions/workflows/R-CMD-check.yaml)
[![Codecov test
coverage](https://codecov.io/gh/r-lib/brio/graph/badge.svg)](https://app.codecov.io/gh/r-lib/brio)
<!-- badges: end -->

Functions to handle basic input output, these functions always read and
write UTF-8 files and provide more explicit control over line endings.

## Reading files

``` r
library(brio)
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
#>   expression                           min   median `itr/sec` mem_alloc `gc/sec`
#>   <bch:expr>                      <bch:tm> <bch:tm>     <dbl> <bch:byt>    <dbl>
#> 1 "brio::read_lines(\"benchmark\… 692.28µs 703.68µs     1417.   15.91KB     0   
#> 2 "readr::read_lines(\"benchmark…   1.79ms   1.89ms      521.    3.73MB     8.30
#> 3 "base::readLines(\"benchmark\"…   2.78ms    2.8ms      357.   31.39KB     0
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
#>   expression                             min median `itr/sec` mem_alloc `gc/sec`
#>   <bch:expr>                         <bch:t> <bch:>     <dbl> <bch:byt>    <dbl>
#> 1 "brio::write_lines(data, \"benchm…   476µs  511µs    1378.         0B     0   
#> 2 "readr::write_lines(data, \"bench…  10.3ms   15ms      66.4     102KB     0   
#> 3 "base::writeLines(data, \"benchma… 500.8µs  528µs    1718.         0B     2.01

unlink("benchmark")
```

## Code of Conduct

Please note that the brio project is released with a [Contributor Code
of Conduct](https://brio.r-lib.org/CODE_OF_CONDUCT.html). By
contributing to this project, you agree to abide by its terms.
