# Combine MCMC samples of two objects

Combines samples of two MCMC objects (with the same parameters, chains
and iterations) using a function.

## Usage

``` r
combine_samples(x, x2, fun = mean, ...)
```

## Arguments

- x:

  An MCMC object.

- x2:

  a second MCMC object.

- fun:

  The function to use to combine the samples. The function must return a
  scalar.

- ...:

  Unused.

## Value

The combined samples as an MCMC object with the same parameters, chains
and iterations as the original objects.

## See also

Other combine:
[`combine_dimensions()`](https://poissonconsulting.github.io/mcmcr/reference/combine_dimensions.md),
[`combine_samples_n()`](https://poissonconsulting.github.io/mcmcr/reference/combine_samples_n.md)

## Examples

``` r
combine_samples(mcmcr_example, mcmcr_example, fun = sum)
#> $alpha
#> [1] 7.43605 9.43605
#> 
#> nchains:  2 
#> niters:  400 
#> 
#> $beta
#>          [,1]     [,2]
#> [1,] 1.943307 3.943307
#> [2,] 3.943307 5.943307
#> 
#> nchains:  2 
#> niters:  400 
#> 
#> $sigma
#> [1] 1.582395
#> 
#> nchains:  2 
#> niters:  400 
#> 
```
