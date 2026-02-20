# MCMC object transposition

Transpose an MCMC object by permuting its parameter dimensions.

## Usage

``` r
mcmc_aperm(x, perm, ...)
```

## Arguments

- x:

  The MCMC object to transpose. Missing parameter dimensions are added
  on the end. If perm = NULL (the default) the parameter dimensions are
  reversed.

- perm:

  A integer vector of the new order for the parameter dimensions.

- ...:

  Unused.

## Value

The modified MCMC object

## See also

Other manipulate:
[`mcmc_map()`](https://poissonconsulting.github.io/mcmcr/reference/mcmc_map.md)
