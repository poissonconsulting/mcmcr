# Bind by Chains.

Binds two MCMC objects (with the same parameters and iterations) by
chains.

## Usage

``` r
# S3 method for class 'mcmcarray'
bind_chains(x, x2, ...)
```

## Arguments

- x:

  An object.

- x2:

  A second object.

- ...:

  Other arguments passed to methods.

## Value

The combined object.

## See also

Other MCMC manipulations:
[`bind_iterations()`](https://poissonconsulting.github.io/universals/reference/bind_iterations.html),
[`collapse_chains()`](https://poissonconsulting.github.io/universals/reference/collapse_chains.html),
[`estimates()`](https://poissonconsulting.github.io/universals/reference/estimates.html),
[`split_chains()`](https://poissonconsulting.github.io/universals/reference/split_chains.html)
