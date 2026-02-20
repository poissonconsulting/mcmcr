# Check mcmcarray **\[deprecated\]**

Check mcmcarray **\[deprecated\]**

## Usage

``` r
check_mcmcarray(x, x_name = substitute(x), error = TRUE)
```

## Arguments

- x:

  The object to check.

- x_name:

  A string of the name of the object.

- error:

  A flag indicating whether to throw an informative error or immediately
  generate an informative message if the check fails.

## Value

An invisible copy of x (it if doesn't throw an error).

## See also

[`check_mcmcr()`](https://poissonconsulting.github.io/mcmcr/reference/check_mcmcr.md)

## Examples

``` r
check_mcmcarray(mcmcr::mcmcr_example$beta)
#> Warning: `check_mcmcarray()` was deprecated in mcmcr v0.2.1.
#> ℹ Please use `chk_mcmcarray()` instead.
```
