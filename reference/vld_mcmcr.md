# Validate MCMC objects

Validates class and structure of MCMC objects.

## Usage

``` r
vld_mcmcarray(x)

vld_mcmcr(x)

vld_mcmcrs(x)
```

## Arguments

- x:

  The object to check.

## Value

A flag indicating whether the object was validated.

## Details

To just validate class use
[`chk::vld_s3_class()`](https://poissonconsulting.github.io/chk/reference/chk_s3_class.html).

## Functions

- `vld_mcmcarray()`: Validate
  [`mcmcarray-object()`](https://poissonconsulting.github.io/mcmcr/reference/mcmcarray-object.md)

- `vld_mcmcr()`: Validate
  [`mcmcr-object()`](https://poissonconsulting.github.io/mcmcr/reference/mcmcr-object.md)

- `vld_mcmcrs()`: Validate
  [`mcmcrs-object()`](https://poissonconsulting.github.io/mcmcr/reference/mcmcrs-object.md)

## See also

[`chk_mcmcr()`](https://poissonconsulting.github.io/mcmcr/reference/chk_mcmcr.md)

## Examples

``` r
#' vld_mcmcarray
vld_mcmcarray(1)
#> [1] FALSE

# vld_mcmcr
vld_mcmcr(1)
#> [1] FALSE
vld_mcmcr(mcmcr::mcmcr_example)
#> [1] TRUE

# vld_mcmcrs
vld_mcmcrs(1)
#> [1] FALSE
```
