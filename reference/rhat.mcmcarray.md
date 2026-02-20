# R-hat

Calculates an R-hat (potential scale reduction factor) value.

## Usage

``` r
# S3 method for class 'mcmcarray'
rhat(x, by = "all", as_df = FALSE, na_rm = FALSE, ...)
```

## Arguments

- x:

  An object.

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

A number \>= 1 indicating the rhat value.

## Details

By default the uncorrected, unfolded, univariate, split R-hat value.

## References

Gelman, A., and Rubin, D.B. 1992. Inference from Iterative Simulation
Using Multiple Sequences. Statistical Science 7(4): 457–472.

## See also

Other convergence:
[`converged()`](https://poissonconsulting.github.io/universals/reference/converged.html),
[`converged_pars()`](https://poissonconsulting.github.io/universals/reference/converged_pars.html),
[`converged_terms()`](https://poissonconsulting.github.io/universals/reference/converged_terms.html),
[`esr()`](https://poissonconsulting.github.io/universals/reference/esr.html),
[`esr_pars()`](https://poissonconsulting.github.io/universals/reference/esr_pars.html),
[`esr_terms()`](https://poissonconsulting.github.io/universals/reference/esr_terms.html),
[`rhat_pars()`](https://poissonconsulting.github.io/universals/reference/rhat_pars.html),
[`rhat_terms()`](https://poissonconsulting.github.io/universals/reference/rhat_terms.html)
