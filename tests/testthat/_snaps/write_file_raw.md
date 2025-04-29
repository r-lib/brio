# write_file_raw errors on invalid inputs

    Code
      write_file_raw("foo", c("bar", tmp))
    Condition
      Error:
      ! `raw` must be a raw vector
    Code
      write_file_raw(charToRaw("foo"), c("bar", tmp))
    Condition
      Error:
      ! `path` must be a single element

