# Subset an MCMC object

Subsets an MCMC object by its chains, iterations and/or parameters.

## Usage

``` r
# S3 method for class 'mcmcarray'
subset(x, chains = NULL, iters = NULL, iterations = NULL, ...)

# S3 method for class 'mcmcr'
subset(
  x,
  chains = NULL,
  iters = NULL,
  pars = NULL,
  iterations = NULL,
  parameters = NULL,
  ...
)

# S3 method for class 'mcmcrs'
subset(
  x,
  chains = NULL,
  iters = NULL,
  pars = NULL,
  iterations = NULL,
  parameters = NULL,
  ...
)
```

## Arguments

- x:

  The MCMC object to subset

- chains:

  An integer vector of chains.

- iters:

  An integer vector of iterations.

- iterations:

  An integer vector (or NULL) of the iterations to subset by.

- ...:

  Unused.

- pars:

  A character vector of parameter names.

- parameters:

  A character vector (or NULL) of the parameters to subset by.

## Methods (by class)

- `subset(mcmcarray)`: Subset an mcmcarray object

- `subset(mcmcr)`: Subset an mcmcr object

- `subset(mcmcrs)`: Subset an mcmcrs object

## See also

[`universals::split_chains()`](https://poissonconsulting.github.io/universals/reference/split_chains.html)

## Examples

``` r
subset(mcmcr_example,
  chains = 2L, iters = 1:100,
  pars = c("beta", "alpha")
)
#> $beta
#>           [,1]     [,2]
#> [1,] 0.7591235 1.759124
#> [2,] 1.7591235 2.759124
#> 
#> nchains:  1 
#> niters:  100 
#> 
#> $alpha
#> [1] 3.044835 4.044835
#> 
#> nchains:  1 
#> niters:  100 
#> 
```
