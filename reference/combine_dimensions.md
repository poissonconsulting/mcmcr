# Combine samples by dimensions

Combines MCMC object samples by dimensions along `along` using `fun`.

## Usage

``` r
combine_dimensions(x, fun = mean, along = NULL, ...)
```

## Arguments

- x:

  An MCMC object

- fun:

  The function to use when combining dimensions

- along:

  A positive integer (or NULL) indicating the parameter dimension(s) to
  bind along.

- ...:

  Unused.

## Value

The MCMC object with reduced dimensions.

## See also

Other combine:
[`combine_samples()`](https://poissonconsulting.github.io/mcmcr/reference/combine_samples.md),
[`combine_samples_n()`](https://poissonconsulting.github.io/mcmcr/reference/combine_samples_n.md)

## Examples

``` r
combine_dimensions(mcmcr_example$alpha)
#> [1] 4.218025
#> 
#> nchains:  2 
#> niters:  400 
```
