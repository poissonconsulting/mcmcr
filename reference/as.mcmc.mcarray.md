# Markov Chain Monte Carlo Objects

The function `mcmc` is used to create a Markov Chain Monte Carlo object.
The input data are taken to be a vector, or a matrix with one column per
variable.

If the optional arguments `start`, `end`, and `thin` are omitted then
the chain is assumed to start with iteration 1 and have thinning
interval 1. If `data` represents a chain that starts at a later
iteration, the first iteration in the chain should be given as the
`start` argument. Likewise, if `data` represents a chain that has
already been thinned, the thinning interval should be given as the
`thin` argument.

An mcmc object may be summarized by the `summary` function and
visualized with the `plot` function.

MCMC objects resemble time series (`ts`) objects and have methods for
the generic functions `time`, `start`, `end`, `frequency` and `window`.

## Usage

``` r
# S3 method for class 'mcarray'
as.mcmc(x, ...)
```

## Arguments

- x:

  An object that may be coerced to an mcmc object

- ...:

  Further arguments to be passed to specific methods

## Note

The format of the mcmc class has changed between coda version 0.3 and
0.4. Older mcmc objects will now cause `is.mcmc` to fail with an
appropriate warning message. Obsolete mcmc objects can be upgraded with
the `mcmcUpgrade` function.

## See also

[`mcmc.list`](https://rdrr.io/pkg/coda/man/mcmc.list.html),
[`mcmcUpgrade`](https://rdrr.io/pkg/coda/man/mcmcUpgrade.html),
[`thin`](https://rdrr.io/pkg/coda/man/thin.html),
[`window.mcmc`](https://rdrr.io/pkg/coda/man/window.mcmc.html),
[`summary.mcmc`](https://rdrr.io/pkg/coda/man/summary.mcmc.html),
[`plot.mcmc`](https://rdrr.io/pkg/coda/man/plot.mcmc.html).

## Author

Martyn Plummer
