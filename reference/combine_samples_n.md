# Combine MCMC samples of multiple objects

Combines samples of multiple MCMC objects (with the same parameters,
chains and iterations) using a function.

## Usage

``` r
combine_samples_n(x, ..., fun = mean)
```

## Arguments

- x:

  An MCMC object (or a list of mcmc objects).

- ...:

  Additional MCMC objects.

- fun:

  A function.

## See also

Other combine:
[`combine_dimensions()`](https://poissonconsulting.github.io/mcmcr/reference/combine_dimensions.md),
[`combine_samples()`](https://poissonconsulting.github.io/mcmcr/reference/combine_samples.md)

## Examples

``` r
combine_samples_n(mcmcr_example, mcmcr_example, mcmcr_example, fun = sum)
#> $alpha
#> [1] 11.15407 14.15407
#> 
#> nchains:  2 
#> niters:  400 
#> 
#> $beta
#>          [,1]     [,2]
#> [1,] 2.914961 5.914961
#> [2,] 5.914961 8.914960
#> 
#> nchains:  2 
#> niters:  400 
#> 
#> $sigma
#> [1] 2.373592
#> 
#> nchains:  2 
#> niters:  400 
#> 
```
