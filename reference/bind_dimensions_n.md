# Combine multiple MCMC objects by parameter dimensions

Combines multiple MCMC objects (with the same parameters, chains and
iterations) by parameter dimensions.

## Usage

``` r
bind_dimensions_n(...)
```

## Arguments

- ...:

  one or more MCMC objects

## See also

[`universals::bind_chains()`](https://poissonconsulting.github.io/universals/reference/bind_chains.html)

Other bind:
[`bind_dimensions()`](https://poissonconsulting.github.io/mcmcr/reference/bind_dimensions.md),
[`bind_parameters()`](https://poissonconsulting.github.io/mcmcr/reference/bind_parameters.md)

## Examples

``` r
bind_dimensions_n(mcmcr_example, mcmcr_example, mcmcr_example)
#> $alpha
#>          [,1]     [,2]     [,3]
#> [1,] 3.718025 3.718025 3.718025
#> [2,] 4.718025 4.718025 4.718025
#> 
#> nchains:  2 
#> niters:  400 
#> 
#> $beta
#> , , 1
#> 
#>           [,1]     [,2]
#> [1,] 0.9716535 1.971654
#> [2,] 1.9716535 2.971654
#> 
#> , , 2
#> 
#>           [,1]     [,2]
#> [1,] 0.9716535 1.971654
#> [2,] 1.9716535 2.971654
#> 
#> , , 3
#> 
#>           [,1]     [,2]
#> [1,] 0.9716535 1.971654
#> [2,] 1.9716535 2.971654
#> 
#> 
#> nchains:  2 
#> niters:  400 
#> 
#> $sigma
#>           [,1]      [,2]      [,3]
#> [1,] 0.7911975 0.7911975 0.7911975
#> 
#> nchains:  2 
#> niters:  400 
#> 
```
