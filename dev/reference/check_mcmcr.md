# Check mcmcr **\[deprecated\]**

Check mcmcr **\[deprecated\]**

## Usage

``` r
check_mcmcr(x, sorted = FALSE, x_name = substitute(x), error = TRUE)
```

## Arguments

- x:

  The object to check.

- sorted:

  A flag specifying whether the parameters must be sorted.

- x_name:

  A string of the name of the object.

- error:

  A flag indicating whether to throw an informative error or immediately
  generate an informative message if the check fails.

## Value

An invisible copy of x (it if doesn't throw an error).

## See also

`check_mcmcr()`

## Examples

``` r
check_mcmcr(mcmcr::mcmcr_example)
#> Warning: `check_mcmcr()` was deprecated in mcmcr v0.2.1.
#> ℹ Please use `chk_mcmcr()` instead.
```
