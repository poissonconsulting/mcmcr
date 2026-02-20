# Term coefficients

Gets coefficients for all the terms in an MCMC object.

## Usage

``` r
# S3 method for class 'mcmc'
coef(object, conf_level = 0.95, estimate = median, simplify = TRUE, ...)
```

## Arguments

- object:

  The MCMC object to get the coefficients for

- conf_level:

  A number specifying the confidence level. By default 0.95.

- estimate:

  The function to use to calculate the estimate.

- simplify:

  A flag specifying whether to return just the estimate, lower, upper
  and svalue.

- ...:

  Unused.

## Value

An data frame of the coefficients with the columns indicating the
`term`, `estimate`, `lower` and `upper` credible intervals and `svalue`

## Methods (by class)

- `coef(mcmc)`: Get coefficients for terms in mcmc object

## See also

[stats::coef](https://rdrr.io/r/stats/coef.html)

## Examples

``` r
coef(mcmcr_example)
#> # A tibble: 7 × 5
#>   term      estimate lower upper svalue
#>   <term>       <dbl> <dbl> <dbl>  <dbl>
#> 1 alpha[1]     3.72  2.21   5.23   9.65
#> 2 alpha[2]     4.72  3.21   6.23   9.65
#> 3 beta[1,1]    0.972 0.251  1.71   5.40
#> 4 beta[2,1]    1.97  1.25   2.71   7.32
#> 5 beta[1,2]    1.97  1.25   2.71   7.32
#> 6 beta[2,2]    2.97  2.25   3.71   9.65
#> 7 sigma        0.791 0.425  2.56   9.65
```
