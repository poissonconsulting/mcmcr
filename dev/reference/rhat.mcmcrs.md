# R-hat

Calculates an R-hat (potential scale reduction factor) value.

## Usage

``` r
# S3 method for class 'mcmcrs'
rhat(x, by = "all", as_df = FALSE, na_rm = FALSE, bound = FALSE, ...)
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

- bound:

  flag specifying whether to bind mcmcrs objects by their chains before
  calculating rhat.

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

## Examples

``` r
rhat(mcmcrs(mcmcr_example, mcmcr_example))
#> $mcmcr1
#> [1] 2.002
#> 
#> $mcmcr2
#> [1] 2.002
#> 
rhat(mcmcrs(mcmcr_example, mcmcr_example), bound = TRUE)
#> Warning: `rhat.mcmcrs(x, bound = TRUE)` returns scalar was deprecated in mcmcr
#> 0.6.1.9001.
#> ℹ Please use `rhat(x, bound = TRUE)$bound` for previous behaviour instead.
#> ℹ `rhat.mcmcrs(bound = TRUE)` now returns named list of scalars.
#> $mcmcr1
#> [1] 2.002
#> 
#> $mcmcr2
#> [1] 2.002
#> 
#> $bound
#> [1] 1.891
#> 
```
