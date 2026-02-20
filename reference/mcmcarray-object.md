# mcmcarray

An `mcmcarray` object is an an array where the first dimension is the
chains, the second dimension is the iterations and the subsequent
dimensions represent the dimensionality of the parameter. The name
`mcmcarray` reflects the fact that the MCMC dimensions, ie the chains
and iterations, precede the parameter dimensions.

## See also

Other objects:
[`mcmcr-object`](https://poissonconsulting.github.io/mcmcr/reference/mcmcr-object.md),
[`mcmcrs-object`](https://poissonconsulting.github.io/mcmcr/reference/mcmcrs-object.md)

## Examples

``` r
mcmcr_example$beta
#>           [,1]     [,2]
#> [1,] 0.9716535 1.971654
#> [2,] 1.9716535 2.971654
#> 
#> nchains:  2 
#> niters:  400 
```
