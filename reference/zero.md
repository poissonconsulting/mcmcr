# Zero MCMC sample values

Zeros an MCMC object's sample values.

## Usage

``` r
zero(x, ...)

# S3 method for class 'mcarray'
zero(x, ...)

# S3 method for class 'mcmcarray'
zero(x, ...)

# S3 method for class 'mcmcr'
zero(x, pars = NULL, ...)
```

## Arguments

- x:

  The MCMC object.

- ...:

  Unused.

- pars:

  A character vector (or NULL) of the pars to zero.

## Value

The MCMC

## Details

It is used for removing the effect of a random effect where the expected
value is 0.

## Methods (by class)

- `zero(mcarray)`: Zero an mcarray object

- `zero(mcmcarray)`: Zero an mcmcarray object

- `zero(mcmcr)`: Zero an mcmcr object

## Examples

``` r
zero(mcmcr_example, pars = "beta")
#> Warning: `zero()` was deprecated in mcmcr v0.2.1.
#> ℹ Please use `fill_all()` instead.
#> $alpha
#> [1] 3.718025 4.718025
#> 
#> nchains:  2 
#> niters:  400 
#> 
#> $beta
#>      [,1] [,2]
#> [1,]    0    0
#> [2,]    0    0
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
