# MCMC map

Adjust the sample values of an MCMC object using a function.

## Usage

``` r
mcmc_map(.x, .f, .by = 1:npdims(.x), ...)
```

## Arguments

- .x:

  An MCMC object

- .f:

  The function to use

- .by:

  A positive integer vector of the dimensions to apply the function
  over.

- ...:

  Additional arguments passed to .f.

## Value

The updated MCMC object.

## See also

Other manipulate:
[`mcmc_aperm()`](https://poissonconsulting.github.io/mcmcr/reference/mcmc_aperm.md)

## Examples

``` r
mcmc_map(mcmcr_example$beta, exp)
#>          [,1]      [,2]
#> [1,] 2.642310  7.182544
#> [2,] 7.182544 19.524180
#> 
#> nchains:  2 
#> niters:  400 
```
