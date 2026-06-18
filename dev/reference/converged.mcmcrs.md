# Converged

Tests whether an object has converged.

## Usage

``` r
# S3 method for class 'mcmcrs'
converged(
  x,
  rhat = 1.1,
  esr = 0.33,
  by = "all",
  as_df = FALSE,
  bound = FALSE,
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

- bound:

  flag specifying whether to bind mcmcrs objects by their chains before
  calculating rhat.

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
converged(mcmcrs(mcmcr_example, mcmcr_example))
#> $mcmcr1
#> [1] FALSE
#> 
#> $mcmcr2
#> [1] FALSE
#> 
converged(mcmcrs(mcmcr_example, mcmcr_example), bound = TRUE)
#> [1] FALSE
```
