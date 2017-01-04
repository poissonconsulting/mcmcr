
<!-- README.md is generated from README.Rmd. Please edit that file -->
[![Travis-CI Build Status](https://travis-ci.org/poissonconsulting/mcmcr.svg?branch=master)](https://travis-ci.org/poissonconsulting/mcmcr) [![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/poissonconsulting/mcmcr?branch=master&svg=true)](https://ci.appveyor.com/project/poissonconsulting/mcmcr) [![Coverage Status](https://img.shields.io/codecov/c/github/poissonconsulting/mcmcr/master.svg)](https://codecov.io/github/poissonconsulting/mcmcr?branch=master)

mcmcr
=====

Introduction
------------

`mcmcr` is an R package to manipulate Monte Carlo Markov Chain samples.

Utilisation
-----------

``` r
library(mcmcr)

mcmcr <- mcmcr:::mcmcr

coef(mcmcr)
#> NULL
convergence(mcmcr)
#> [1] 1.734326

plot(mcmcr[[3]])
```

![](README-unnamed-chunk-2-1.png)

Installation
------------

To install the latest version from GitHub

    # install.packages("devtools")
    devtools::install_github("poissonconsulting/mcmcr")

Contribution
------------

Please report any [issues](https://github.com/poissonconsulting/mcmcr/issues).

[Pull requests](https://github.com/poissonconsulting/mcmcr/pulls) are always welcome.

Inspiration
-----------

-   coda and rjags
