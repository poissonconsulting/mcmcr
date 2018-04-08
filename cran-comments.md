## Test environments
* local OS X install, R 3.4.4
* Ubuntu 14.04.5 LTS (on travis-ci), R 3.4.4
* win-builder (devel and release)

## R CMD check results

* checking CRAN incoming feasibility ... NOTE
Maintainer: ‘Joe Thorley <joe@poissonconsulting.ca>’
New submission

* checking S3 generic/method consistency ... NOTE
Found the following apparent S3 methods exported but not registered:
  as.mcmc.list
See section ‘Registering S3 methods’ in the ‘Writing R Extensions’
manual.

0 errors | 0 warnings | 2 notes

## R CMD check response

- This is a new release.

- This is due to the name of as.mcmc.list which has a check exclusion in R-devel/src/library/tools/R/utils.R for package coda.

## Reverse dependencies

This is a new release, so there are no reverse dependencies.
