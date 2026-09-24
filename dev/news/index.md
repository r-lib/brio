# Changelog

## brio (development version)

- [`read_lines()`](https://brio.r-lib.org/dev/reference/read_lines.md)
  now uses `Rf_xlengthgets()` when shrinking its result vector, avoiding
  truncation of the line count for files with 2^31 or more lines
  ([@jimhester](https://github.com/jimhester),
  [\#34](https://github.com/r-lib/brio/issues/34)).

## brio 1.1.5

CRAN release: 2024-04-24

- brio now works in WebR.

## brio 1.1.4

CRAN release: 2023-12-10

- `printf()`-like format strings are now safer.

## brio 1.1.3

CRAN release: 2021-11-30

- Gábor Csárdi is now the maintainer.

- New
  [`write_file_raw()`](https://brio.r-lib.org/dev/reference/write_file_raw.md)
  function to write a raw vector to a file.

- Fix memory leak in
  [`read_lines()`](https://brio.r-lib.org/dev/reference/read_lines.md)
  ([@ms609](https://github.com/ms609),
  [\#20](https://github.com/r-lib/brio/issues/20))

## brio 1.1.2

CRAN release: 2021-04-23

- Input filenames are now automatically converted to UTF-8 from the
  native encoding ([@gaborcsardi](https://github.com/gaborcsardi),
  [\#15](https://github.com/r-lib/brio/issues/15))

- [`read_file_raw()`](https://brio.r-lib.org/dev/reference/read_file.md)
  now closes file handles ([@pbarber](https://github.com/pbarber),
  [\#16](https://github.com/r-lib/brio/issues/16))

## brio 1.1.1

CRAN release: 2021-01-20

- [`file_line_endings()`](https://brio.r-lib.org/dev/reference/file_line_endings.md)
  now works as expected on ARM systems
  ([\#8](https://github.com/r-lib/brio/issues/8))

## brio 1.1.0

CRAN release: 2020-08-31

- New
  [`write_file()`](https://brio.r-lib.org/dev/reference/write_file.md)
  function to write an entire file
  ([\#7](https://github.com/r-lib/brio/issues/7))

- [`read_lines()`](https://brio.r-lib.org/dev/reference/read_lines.md)
  no longer leaks file handles.

- Added a `NEWS.md` file to track changes to the package.

## brio 1.0.0

CRAN release: 2020-03-26

- Initial release
