# P-Value effective sample size

Calculates the effective sample size based on
[`esr()`](https://poissonconsulting.github.io/universals/reference/esr.html).

## Usage

``` r
ess(x, by = "all", as_df = FALSE)
```

## Arguments

- x:

  An MCMC object.

- by:

  A string indicating whether to determine by "term", "parameter" or
  "all".

- as_df:

  A flag indicating whether to return the results as a data frame versus
  a named list.

## See also

[universals::esr](https://poissonconsulting.github.io/universals/reference/esr.html)

## Examples

``` r
ess(mcmcr_example)
#> [1] 9
```
