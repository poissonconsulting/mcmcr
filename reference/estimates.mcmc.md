# Estimates

Calculates the estimates for an MCMC object.

## Usage

``` r
# S3 method for class 'mcmc'
estimates(x, fun = median, as_df = FALSE, ...)
```

## Arguments

- x:

  An object.

- fun:

  A function that given a numeric vector returns a numeric scalar.

- as_df:

  A flag indicating whether to return the results as a data frame versus
  a named list.

- ...:

  Optional arguments to fun.

## Value

A named list or data frame.

## See also

Other MCMC manipulations:
[`bind_chains()`](https://poissonconsulting.github.io/universals/reference/bind_chains.html),
[`bind_iterations()`](https://poissonconsulting.github.io/universals/reference/bind_iterations.html),
[`collapse_chains()`](https://poissonconsulting.github.io/universals/reference/collapse_chains.html),
[`split_chains()`](https://poissonconsulting.github.io/universals/reference/split_chains.html)
