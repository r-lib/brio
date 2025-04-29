# write_file errors on invalid inputs

    Code
      write_file(c("foo", "bar"), tmp)
    Condition
      Error:
      ! `text` cannot have more than one element
    Code
      write_file("foo", c("bar", tmp))
    Condition
      Error:
      ! `path` must be a single element

