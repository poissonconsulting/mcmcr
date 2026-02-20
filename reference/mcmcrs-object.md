# mcmcrs

An `mcmcrs` object stores multiple
[`mcmcr-object()`](https://poissonconsulting.github.io/mcmcr/reference/mcmcr-object.md)s
with the same parameters and the same number of chains and iterations.

## Details

`mcmcrs` objects allow the results of multiple analyses using the same
model to be manipulated and queried as a whole.

## See also

Other objects:
[`mcmcarray-object`](https://poissonconsulting.github.io/mcmcr/reference/mcmcarray-object.md),
[`mcmcr-object`](https://poissonconsulting.github.io/mcmcr/reference/mcmcr-object.md)

## Examples

``` r
mcmcrs(mcmcr_example, mcmcr_example)
#> $mcmcr1
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
#> 
#> $mcmcr2
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
#> 
#> attr(,"class")
#> [1] "mcmcrs"
```
