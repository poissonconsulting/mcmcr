# Is mcmcrs object

Tests whether an object is an
[`mcmcrs-object()`](https://poissonconsulting.github.io/mcmcr/reference/mcmcrs-object.md).

## Usage

``` r
is.mcmcrs(x)
```

## Arguments

- x:

  The object to test.

## Value

A flag indicating whether the test was positive.

## See also

Other is:
[`is.mcarray()`](https://poissonconsulting.github.io/mcmcr/reference/is.mcarray.md),
[`is.mcmcarray()`](https://poissonconsulting.github.io/mcmcr/reference/is.mcmcarray.md),
[`is.mcmcr()`](https://poissonconsulting.github.io/mcmcr/reference/is.mcmcr.md)

## Examples

``` r
is.mcmcrs(mcmcrs(mcmcr_example))
#> [1] TRUE
```
