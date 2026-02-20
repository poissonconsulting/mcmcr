# Combine two MCMC object by parameters

Combines two MCMC objects (with the same chains and iterations) by their
parameters.

## Usage

``` r
bind_parameters(x, x2, ...)
```

## Arguments

- x:

  an MCMC object

- x2:

  a second MCMC object.

- ...:

  Unused.

## See also

[`universals::bind_chains()`](https://poissonconsulting.github.io/universals/reference/bind_chains.html)

Other bind:
[`bind_dimensions()`](https://poissonconsulting.github.io/mcmcr/reference/bind_dimensions.md),
[`bind_dimensions_n()`](https://poissonconsulting.github.io/mcmcr/reference/bind_dimensions_n.md)

## Examples

``` r
bind_parameters(
  subset(mcmcr_example, pars = "sigma"),
  subset(mcmcr_example, pars = "beta")
)
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
