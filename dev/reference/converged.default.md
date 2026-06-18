# Converged

Tests whether an object has converged.

## Usage

``` r
# Default S3 method
converged(
  x,
  rhat = 1.1,
  esr = 0.33,
  by = "all",
  as_df = FALSE,
  na_rm = FALSE,
  ...
)
```

## Arguments

- x:

  An object.

- rhat:

  The maximum rhat value.

- esr:

  The minimum effective sampling rate.

- by:

  A string indicating whether to determine by "term", "parameter" or
  "all".

- as_df:

  A flag indicating whether to return the results as a data frame versus
  a named list.

- na_rm:

  A flag specifying whether to ignore missing values.

- ...:

  Other arguments passed to methods.

## Value

A logical scalar indicating whether the object has converged.

## See also

Other convergence:
[`converged_pars()`](https://poissonconsulting.github.io/universals/reference/converged_pars.html),
[`converged_terms()`](https://poissonconsulting.github.io/universals/reference/converged_terms.html),
[`esr()`](https://poissonconsulting.github.io/universals/reference/esr.html),
[`esr_pars()`](https://poissonconsulting.github.io/universals/reference/esr_pars.html),
[`esr_terms()`](https://poissonconsulting.github.io/universals/reference/esr_terms.html),
[`rhat()`](https://poissonconsulting.github.io/universals/reference/rhat.html),
[`rhat_pars()`](https://poissonconsulting.github.io/universals/reference/rhat_pars.html),
[`rhat_terms()`](https://poissonconsulting.github.io/universals/reference/rhat_terms.html)

## Examples

``` r
converged(mcmcr_example)
#> [1] FALSE
```
