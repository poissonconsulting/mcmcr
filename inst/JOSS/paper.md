---
title: 'mcmcr: An R package to manipulate Markov Chain Monte Carlo samples'
authors:
- affiliation: 1
  name: Joe Thorley
  orcid: 0000-0002-7683-4592
affiliations:
  index: 1
  name: Poisson Consulting, Nelson, British Columbia
tags: 
  - R
  - MCMC
  - Bayesian
bibliography: paper.bib
date: "2018-04-07"
output: 
  html_document: 
    keep_md: yes
---



## Summary

The results of Bayesian analyses are fully described by the posterior distribution for each term in the model.
Bayesian software packages such as BUGS, JAGS and STAN use one or more chains to iteratively draw samples from the posterior distributions using Markov Chain Monte Carlo (MCMC) methods.

While a simple *parameter* such as an intercept corresponds to a single term, more complex parameters consist of multiple terms with their own inherent dimensionality.

The `mcmcr` package includes two related classes which preserve the dimensionality of the parameters.
The first, `mcmcr::mcmcarray`, stores the samples in an array where the first dimension is the chains, the second dimension is the iterations and the subsequent dimensions represent the dimensionality of the parameter. 
The second class, `mcmcr::mcmcr`, stores multiple `mcmcarray` objects with the same number of chains and iterations. 
It was developed to allow a set of dimensionality preserving parameters from a single analysis to be manipulated as a whole.

The package includes functions to:

- coerce to and from other MCMC storing classes such as `mcarray` and `mcmc.list` objects; 
- assess if an object has `converged` using `rhat` and `esr` (effectively sampling rate);
- extract an object's `coef` table; 
- `subset` an object by its chains, iterations and/or parameters;
- bind a pair of objects by their chains, iterations, parameters or (parameter) dimensions;
- collapse or split an object's chains;
- `mcmc_map` over an objects values.

The `mcmcr` package provides an integrated framework for storing, manipulating and summarising MCMC samples.


```r
library(mcmcr)

mcmcr_example
```

```
## $alpha
## [1] 3.718025 4.718025
## nchains:  2 
## niters:  400 
## 
## $beta
##           [,1]     [,2]
## [1,] 0.9716535 1.971654
## [2,] 1.9716535 2.971654
## nchains:  2 
## niters:  400 
## 
## $sigma
## [1] 0.7911975
## nchains:  2 
## niters:  400
```

```r
coef(mcmcr_example)
```

```
## # A tibble: 7 x 7
##   term       estimate    sd zscore lower upper  pvalue
##   <S3: term>    <dbl> <dbl>  <dbl> <dbl> <dbl>   <dbl>
## 1 alpha[1]      3.72  0.901   4.15 2.21   5.23 0.00120
## 2 alpha[2]      4.72  0.901   5.26 3.21   6.23 0.00120
## 3 beta[1,1]     0.972 0.375   2.57 0.251  1.71 0.0225 
## 4 beta[2,1]     1.97  0.375   5.24 1.25   2.71 0.00500
## 5 beta[1,2]     1.97  0.375   5.24 1.25   2.71 0.00500
## 6 beta[2,2]     2.97  0.375   7.91 2.25   3.71 0.00120
## 7 sigma         0.791 0.741   1.31 0.425  2.56 0.00120
```

The software archive is at <https://github.com/poissonconsulting/mcmcr>.

## References
