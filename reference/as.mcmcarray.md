# Coerce to an mcmcarray object

Coerces MCMC objects to an
[`mcmcarray-object()`](https://poissonconsulting.github.io/mcmcr/reference/mcmcarray-object.md).

## Usage

``` r
as.mcmcarray(x, ...)
```

## Arguments

- x:

  object to coerce.

- ...:

  Unused.

## See also

Other coerce:
[`as.mcarray()`](https://poissonconsulting.github.io/mcmcr/reference/as.mcarray.md),
[`as.mcmcr()`](https://poissonconsulting.github.io/mcmcr/reference/as.mcmcr.md),
[`mcmcrs()`](https://poissonconsulting.github.io/mcmcr/reference/mcmcrs.md)

## Examples

``` r
as.mcmcarray(as.mcarray(mcmcr_example$beta))
#>           [,1]     [,2]
#> [1,] 0.9716535 1.971654
#> [2,] 1.9716535 2.971654
#> 
#> nchains:  2 
#> niters:  400 
```
