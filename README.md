
<!-- README.md is generated from README.Rmd. Please edit that file -->

[![lifecycle](https://img.shields.io/badge/lifecycle-maturing-blue.svg)](https://www.tidyverse.org/lifecycle/#maturing)
[![Travis-CI Build
Status](https://travis-ci.org/poissonconsulting/mcmcr.svg?branch=master)](https://travis-ci.org/poissonconsulting/mcmcr)
[![AppVeyor Build
Status](https://ci.appveyor.com/api/projects/status/github/poissonconsulting/mcmcr?branch=master&svg=true)](https://ci.appveyor.com/project/poissonconsulting/mcmcr)
[![Coverage
Status](https://img.shields.io/codecov/c/github/poissonconsulting/mcmcr/master.svg)](https://codecov.io/github/poissonconsulting/mcmcr?branch=master)
[![License:
MIT](https://img.shields.io/badge/License-MIT-green.svg)](https://opensource.org/licenses/MIT)

# mcmcr

## Introduction

`mcmcr` is an R package to manipulate Monte Carlo Markov Chain (MCMC)
samples.

For the purposes of this discussion, an MCMC sample represents the value
of a term from a single iteration of a single chain (of a single
analysis). And while a simple parameter such as an intercept corresponds
to a single term, more complex parameters such as an interaction between
two factors consist of multiple terms with their own inherent
dimensionality - in this case a matrix. Not surprisingly a set of MCMC
samples can be stored in different ways. The three most common S3
classes store MCMC samples as follows:

  - `coda::mcmc` stores the MCMC samples from a single chain as a matrix
    where each each row represents an iteration and each column
    represents a variable
  - `coda::mcmc.list` stores multiple `mcmc` objects (with identical
    dimensions) as a list where each object represents a parallel chain
  - `rjags::mcarray` stores the samples from a single parameter where
    the initial dimensions are the parameter dimensions, the second to
    last dimension is iterations and the last dimension is chains.

In the first two cases the terms/parameters are represented by a single
dimension which means that the dimensionality inherent in the parameters
is stored in the labelling of the variables, ie, `"bIntercept",
"bInteraction[1,2]", "bInteraction[2,1]", ...`. The structure of the
`mcmc` and `mcmc.list` objects emphasizes the time-series nature of MCMC
samples and is optimized for thining. In contrast `mcarray` objects
preserve the dimensionality of the parameters.

The `mcmcr` packages introduces two related S3 classes which also
preserve the dimensionality of the parameters:

  - `mcmcr::mcmcarray` is very similar to `rjags::mcarray` except that
    the first dimension is the chains, the second dimension is
    iterations and the subsequent dimensions represent the
    dimensionality of the parameter (it is called `mcmcarray` to
    emphasize that the MCMC dimensions ie the chains and iterations come
    first);
  - `mcmcr::mcmcr` stores multiple uniquely named `mcmcarray` objects
    with the same number of chains and iterations.

## Why mcmcr?

`mcmcarray` objects were introduced to facilitate manipulation and
querying of the MCMC samples - although they are are just one `aperm`
away from `mcarray` objects they are more intuitive to program with (at
least for this programmer\!) `mcmcr` objects were introduced to allow a
set of parameters to be manipulated and queried as a coherent whole.

The `mcmcr` package introduces a variety of (often) generic functions to
manipulate and query `mcmcarray` and `mcmcr` objects. In particular it
provides functions to

  - coerce from and to `mcarray`, `mcmc` and `mcmc.list` objects;
  - extract an objects `coef` table as a tibble;
  - query an object’s `nchains`, `niters`, `npars`, `nterms`, `nsims`
    and `nsams` as well as it’s parameter dimensions (`pdims`)
  - `subset` objects by chains, iterations and/or parameters;
  - `bind_xx` a pair of objects by their chains, iterations, parameters
    or parameter dimensions;
  - `combine_samples` of two objects by summing or otherwise aggregating
    their MCMC sample values;
  - `collapse_chains` or `split_chains` an object’s chains;
  - `mcmc_map` over an objects values;
  - assess if an object has `converged` using `rhat` and `esr`
    (effectively sampling rate);
  - and of course `thin`, `rhat`, `ess` (effective sample size),
    `print`, `plot` etc said objects.

The `mcmcr` package also provides the R equivalent to functions such as
`pow()`, `logit() <-` that often occur in JAGS/BUGS, STAN, ADMB/TMB
model code.

Finally, the mcmcr package allows the user to `derive` an `mcmcr` object
of new parameters (with potentially novel dimensionality) from an
existing `mcmcr` object using standard R code. No more rerunning a model
because you forget to include a derived parameter\!

## Demonstration

``` r
library(mcmcr)
#> 
#> Attaching package: 'mcmcr'
#> The following object is masked from 'package:stats':
#> 
#>     terms

mcmcr_example
#> $alpha
#> [1] 3.01883 4.01883
#> nchains:  2 
#> niters:  200 
#> 
#> $beta
#>         [,1]    [,2]
#> [1,] 0.79625 1.79625
#> [2,] 1.79625 2.79625
#> nchains:  2 
#> niters:  200 
#> 
#> $sigma
#> [1] 0.7911975
#> nchains:  2 
#> niters:  200

coef(mcmcr_example)
#> # A tibble: 7 x 7
#>   term       estimate    sd zscore lower upper  pvalue
#>   <S3: term>    <dbl> <dbl>  <dbl> <dbl> <dbl>   <dbl>
#> 1 alpha[1]      3.02  0.498   5.99 1.97   3.88 0.00250
#> 2 alpha[2]      4.02  0.498   8.00 2.97   4.88 0.00250
#> 3 beta[1,1]     0.796 0.337   2.37 0.143  1.47 0.0300 
#> 4 beta[2,1]     1.80  0.337   5.34 1.14   2.47 0.00500
#> 5 beta[1,2]     1.80  0.337   5.34 1.14   2.47 0.00500
#> 6 beta[2,2]     2.80  0.337   8.31 2.14   3.47 0.00250
#> 7 sigma         0.791 0.741   1.31 0.425  2.56 0.00250
rhat(mcmcr_example, by = "term")
#> $alpha
#> [1] 1 1
#> 
#> $beta
#>      [,1] [,2]
#> [1,]    1    1
#> [2,]    1    1
#> 
#> $sigma
#> [1] 1
plot(mcmcr_example[["alpha"]])
```

![](tools/README-unnamed-chunk-2-1.png)<!-- -->

``` r

gamma <- derive(mcmcr_example, "gamma <- sum(alpha) * sigma")
plot(gamma)
```

![](tools/README-unnamed-chunk-2-2.png)<!-- -->

## Installation

To install the latest version from GitHub

    # install.packages("devtools")
    devtools::install_github("poissonconsulting/mcmcr")

## Citation

``` 

To cite package 'mcmcr' in publications use:

  Joe Thorley (2018). mcmcr: Manipulate MCMC Samples. R package
  version 0.0.0.9045.

A BibTeX entry for LaTeX users is

  @Manual{,
    title = {mcmcr: Manipulate MCMC Samples},
    author = {Joe Thorley},
    year = {2018},
    note = {R package version 0.0.0.9045},
  }
```

## Contribution

Please report any
[issues](https://github.com/poissonconsulting/mcmcr/issues).

[Pull requests](https://github.com/poissonconsulting/mcmcr/pulls) are
always welcome.

Please note that this project is released with a [Contributor Code of
Conduct](CONDUCT.md). By participating in this project you agree to
abide by its terms.

## Inspiration

[coda](https://github.com/cran/coda) and
[rjags](https://github.com/cran/rjags)
