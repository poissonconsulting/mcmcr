# Effective Sampling Rate

Calculates the effective sampling rate (`esr`).

## Usage

``` r
# S3 method for class 'mcmcr'
esr(x, by = "all", as_df = FALSE, na_rm = FALSE, ...)
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

A number between 0 and 1 indicating the esr value.

## Details

By default \$\$\frac{1}{1 + 2 \sum\_{k = 1}^\infty\rho_k(\theta)}\$\$
from Brooks et al. (2011) where the infinite sum is truncated at lag
\\k\\ when \\\rho\_{k+1}(\theta) \< 0\\.

## References

Brooks, S., Gelman, A., Jones, G.L., and Meng, X.-L. (Editors). 2011.
Handbook for Markov Chain Monte Carlo. Taylor & Francis, Boca Raton.

## See also

Other convergence:
[`converged()`](https://poissonconsulting.github.io/universals/reference/converged.html),
[`converged_pars()`](https://poissonconsulting.github.io/universals/reference/converged_pars.html),
[`converged_terms()`](https://poissonconsulting.github.io/universals/reference/converged_terms.html),
[`esr_pars()`](https://poissonconsulting.github.io/universals/reference/esr_pars.html),
[`esr_terms()`](https://poissonconsulting.github.io/universals/reference/esr_terms.html),
[`rhat()`](https://poissonconsulting.github.io/universals/reference/rhat.html),
[`rhat_pars()`](https://poissonconsulting.github.io/universals/reference/rhat_pars.html),
[`rhat_terms()`](https://poissonconsulting.github.io/universals/reference/rhat_terms.html)

## Examples

``` r
esr(mcmcr_example)
#> [1] 0.011
```
