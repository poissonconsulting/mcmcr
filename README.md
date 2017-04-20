
<!-- README.md is generated from README.Rmd. Please edit that file -->
![stability-unstable](https://img.shields.io/badge/stability-unstable-yellow.svg) [![Travis-CI Build Status](https://travis-ci.org/poissonconsulting/mcmcr.svg?branch=master)](https://travis-ci.org/poissonconsulting/mcmcr) [![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/poissonconsulting/mcmcr?branch=master&svg=true)](https://ci.appveyor.com/project/poissonconsulting/mcmcr) [![Coverage Status](https://img.shields.io/codecov/c/github/poissonconsulting/mcmcr/master.svg)](https://codecov.io/github/poissonconsulting/mcmcr?branch=master) [![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)

mcmcr
=====

Introduction
------------

`mcmcr` is an R package to manipulate Monte Carlo Markov Chain samples.

Utilisation
-----------

``` r
library(mcmcr)
#> Loading required package: coda
#> Loading required package: dplyr
#> 
#> Attaching package: 'dplyr'
#> The following objects are masked from 'package:stats':
#> 
#>     filter, lag
#> The following objects are masked from 'package:base':
#> 
#>     intersect, setdiff, setequal, union

mcmcr <- mcmcr:::mcmcr

nchains(mcmcr)
#> [1] 2
niters(mcmcr)
#> [1] 1000
parameters(mcmcr)
#> [1] "alpha" "beta"  "sigma"
nterms(mcmcr)
#> [1] 7

coef(mcmcr)
#> $alpha
#> # A tibble: 2 × 7
#>         term estimate        sd   zscore   lower    upper pvalue
#>   <S3: term>    <dbl>     <dbl>    <dbl>   <dbl>    <dbl>  <dbl>
#> 1        [1] 2.998247 0.5200369 5.780869 2.00839 4.000345  1e-03
#> 2        [2] 3.998247 0.5200369 7.703810 3.00839 5.000345  5e-04
#> 
#> $beta
#> # A tibble: 4 × 7
#>         term estimate        sd   zscore     lower    upper pvalue
#>   <S3: term>    <dbl>     <dbl>    <dbl>     <dbl>    <dbl>  <dbl>
#> 1      [1,1] 1.265929 0.6219194 2.050184 0.1597749 2.325026  0.023
#> 2      [2,1] 2.265929 0.6219194 3.658109 1.1597749 3.325026  0.001
#> 3      [1,2] 1.332370 0.6191552 2.123673 0.2768236 2.399943  0.015
#> 4      [2,2] 2.332370 0.6191552 3.738777 1.2768236 3.399943  0.002
#> 
#> $sigma
#> # A tibble: 1 × 7
#>         term  estimate        sd   zscore    lower    upper pvalue
#>   <S3: term>     <dbl>     <dbl>    <dbl>    <dbl>    <dbl>  <dbl>
#> 1            0.8265352 0.6637312 1.516797 0.423992 2.726438  5e-04
#> # A tibble: 7 × 7
#>         term  estimate        sd   zscore     lower    upper pvalue
#> * <S3: term>     <dbl>     <dbl>    <dbl>     <dbl>    <dbl>  <dbl>
#> 1   alpha[1] 2.9982470 0.5200369 5.780869 2.0083900 4.000345 0.0010
#> 2   alpha[2] 3.9982470 0.5200369 7.703810 3.0083900 5.000345 0.0005
#> 3  beta[1,1] 1.2659291 0.6219194 2.050184 0.1597749 2.325026 0.0230
#> 4  beta[2,1] 2.2659291 0.6219194 3.658109 1.1597749 3.325026 0.0010
#> 5  beta[1,2] 1.3323697 0.6191552 2.123673 0.2768236 2.399943 0.0150
#> 6  beta[2,2] 2.3323697 0.6191552 3.738777 1.2768236 3.399943 0.0020
#> 7      sigma 0.8265352 0.6637312 1.516797 0.4239920 2.726438 0.0005
rhat(mcmcr)
#> [1] 1.01

estimates(mcmcr)
#> $alpha
#> [1] 2.998247 3.998247
#> 
#> $beta
#>          [,1]    [,2]
#> [1,] 1.265929 1.33237
#> [2,] 2.265929 2.33237
#> 
#> $sigma
#> [1] 0.8265352

plot(mcmcr[[1]])
```

![](tools/README-unnamed-chunk-2-1.png)

Installation
------------

To install the latest version from GitHub

    # install.packages("devtools")
    devtools::install_github("poissonconsulting/mcmcr")

Contribution
------------

Please report any [issues](https://github.com/poissonconsulting/mcmcr/issues).

[Pull requests](https://github.com/poissonconsulting/mcmcr/pulls) are always welcome.

Please note that this project is released with a [Contributor Code of Conduct](CONDUCT.md). By participating in this project you agree to abide by its terms.

Inspiration
-----------

-   coda and rjags
