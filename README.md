# brio - Basic R Input Output

<!-- badges: start -->
<!-- badges: end -->

Functions to handle basic input output, these functions always
read and write UTF-8 files and provide more explicit control over line endings.

## Reading files

``` r
library(brio)
write_lines(c("abc", "123"), "my-file")

# With windows newlines
write_lines(c("abc", "123"), "my-file-2", eol = "\r\n")

file_line_ending("my-file")

file_line_ending("my-file-2")

read_lines("my-file")

unlink(c("my_file", "my-file-2"))
```
