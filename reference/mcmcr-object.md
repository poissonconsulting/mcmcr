# mcmcr

An `mcmcr` object stores multiple uniquely named
[`mcmcarray-object()`](https://poissonconsulting.github.io/mcmcr/reference/mcmcarray-object.md)
objects with the same number of chains and iterations.

## Details

`mcmcr` objects allow a set of dimensionality preserving parameters to
be manipulated and queried as a whole.

## See also

Other objects:
[`mcmcarray-object`](https://poissonconsulting.github.io/mcmcr/reference/mcmcarray-object.md),
[`mcmcrs-object`](https://poissonconsulting.github.io/mcmcr/reference/mcmcrs-object.md)

## Examples

``` r
mcmcr_example
#> $alpha
#> [1] 3.718025 4.718025
#> 
#> nchains:  2 
#> niters:  400 
#> 
#> $beta
#>           [,1]     [,2]
#> [1,] 0.9716535 1.971654
#> [2,] 1.9716535 2.971654
#> 
#> nchains:  2 
#> niters:  400 
#> 
#> $sigma
#> [1] 0.7911975
#> 
#> nchains:  2 
#> niters:  400 
#> 
```
