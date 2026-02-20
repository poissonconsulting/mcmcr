# R-hat

Calculates an R-hat (potential scale reduction factor) value.

## Usage

``` r
# S3 method for class 'mcmcr'
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

## Examples

``` r
rhat(mcmcr_example)
#> [1] 2.002
rhat(mcmcr_example, by = "parameter")
#> $alpha
#> [1] 2.002
#> 
#> $beta
#> [1] 1.147
#> 
#> $sigma
#> [1] 1
#> 
rhat(mcmcr_example, by = "term")
#> $alpha
#> [1] 2.002 2.002
#> 
#> $beta
#>       [,1]  [,2]
#> [1,] 1.147 1.147
#> [2,] 1.147 1.147
#> 
#> $sigma
#> [1] 1
#> 
rhat(mcmcr_example, by = "term", as_df = TRUE)
#> # A tibble: 7 × 2
#>   term       rhat
#>   <term>    <dbl>
#> 1 alpha[1]   2.00
#> 2 alpha[2]   2.00
#> 3 beta[1,1]  1.15
#> 4 beta[2,1]  1.15
#> 5 beta[1,2]  1.15
#> 6 beta[2,2]  1.15
#> 7 sigma      1   
```
