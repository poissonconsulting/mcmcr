# Is mcmcarray object

Tests whether an object is an
[`mcmcarray-object()`](https://poissonconsulting.github.io/mcmcr/dev/reference/mcmcarray-object.md).

## Usage

``` r
is.mcmcarray(x)
```

## Arguments

- x:

  The object to test.

## Value

A flag indicating whether the test was positive.

## See also

Other is:
[`is.mcarray()`](https://poissonconsulting.github.io/mcmcr/dev/reference/is.mcarray.md),
[`is.mcmcr()`](https://poissonconsulting.github.io/mcmcr/dev/reference/is.mcmcr.md),
[`is.mcmcrs()`](https://poissonconsulting.github.io/mcmcr/dev/reference/is.mcmcrs.md)

## Examples

``` r
is.mcmcarray(mcmcr_example$beta)
#> [1] TRUE
```
