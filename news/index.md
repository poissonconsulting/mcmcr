# Changelog

## mcmcr 0.6.2

CRAN release: 2025-01-23

- Depends on R \>= 4.0.
- When `bound = TRUE`
  [`rhat()`](https://poissonconsulting.github.io/universals/reference/rhat.html)
  now also returns rhat values for separate analyses.
- When `bound = TRUE` and `as_df = TRUE`
  [`rhat()`](https://poissonconsulting.github.io/universals/reference/rhat.html)
  now returns a data.frame with the rhat values for the separate and
  combined analyses.

## mcmcr 0.6.1

CRAN release: 2021-09-06

- Update testing to testthat 3.

## mcmcr 0.6.0

CRAN release: 2021-08-05

- Added
  [`fill_na()`](https://poissonconsulting.github.io/extras/reference/fill_na.html)
  for `mcarray`, `mcmcarray` and `mcmcr`.
- Fixed `as.mcmcarray.mcmc()` (and
  [`as.mcmcr.mcmc()`](https://poissonconsulting.github.io/mcmcr/reference/as.mcmcr.md))
  so now returns an `mcmcarray` (and `mcmcr`) object with no terms.

## mcmcr 0.5.0

CRAN release: 2021-02-11

- Added
  - `tidy.mcmcr()`.
  - `simplify = FALSE` argument to
    [`coef()`](https://poissonconsulting.github.io/mcmcr/reference/coef.md)
    and [`tidy()`](https://generics.r-lib.org/reference/tidy.html) and
    soft-deprecated if not `TRUE`.
  - `...` optional arguments for `fun = median` argument to
    [`estimates()`](https://poissonconsulting.github.io/universals/reference/estimates.html).
- Moved `as_nlists.mcmc.list()` to nlist package.

## mcmcr 0.4.0

CRAN release: 2020-09-27

- Added `as_mcmc_list.mcmr()`.
- Moved the following to `nlist`
  - `as_nlist.mcmc()` and `as_nlist.mcmc.list()`
  - `as_nlists.mcmc()`
  - `as.term.mcmc()` and `as.term.mcmc.list()`
  - `bind_iterations.mcmc()` and `bind_iterations.mcmc.list()`
  - `collapse_chains.default()` and `collapse_chains.mcmc.list()`

## mcmcr 0.3.0

CRAN release: 2020-07-13

- Changed
  - `npdims.mcmc.list()` to return character vector (as opposed to list)
  - `collapse_chains.mcmc.list()` to return an mcmc.list object with one
    chain (as opposed to an mcmc object)
  - first argument of
    [`estimates()`](https://poissonconsulting.github.io/universals/reference/estimates.html)
    from `object` to `x`.
  - `scalar_only = FALSE` argument of
    [`pars()`](https://poissonconsulting.github.io/universals/reference/pars.html)
    to `scalar = NA`.
  - [`estimates()`](https://poissonconsulting.github.io/universals/reference/estimates.html)
    so now checks fun returns scalar numeric.
- Soft-deprecated
  - [`pvalue()`](https://poissonconsulting.github.io/extras/reference/pvalue.html)
    for
    [`extras::pvalue()`](https://poissonconsulting.github.io/extras/reference/pvalue.html).
  - [`zero()`](https://poissonconsulting.github.io/mcmcr/reference/zero.md)
    for
    [`fill_all()`](https://poissonconsulting.github.io/extras/reference/fill_all.html).
  - [`check_mcmcarray()`](https://poissonconsulting.github.io/mcmcr/reference/check_mcmcarray.md)
    and
    [`check_mcmcr()`](https://poissonconsulting.github.io/mcmcr/reference/check_mcmcr.md)
    for
    [`chk_mcmcarray()`](https://poissonconsulting.github.io/mcmcr/reference/chk_mcmcr.md)
    and
    [`chk_mcmcr()`](https://poissonconsulting.github.io/mcmcr/reference/chk_mcmcr.md).
  - `iterations` argument with `iters` in
    [`subset()`](https://poissonconsulting.github.io/mcmcr/reference/subset.md).
  - `parameters` argument with `pars` in
    [`subset()`](https://poissonconsulting.github.io/mcmcr/reference/subset.md).
- Added
  - `vld_()` and `chk_()` functions for mcmcarray and mcmcr objects.
  - `scalar = NULL` argument to
    [`pars()`](https://poissonconsulting.github.io/universals/reference/pars.html)
    and
    [`npars()`](https://poissonconsulting.github.io/universals/reference/npars.html).
  - `na_rm = NA` argument to
    [`esr()`](https://poissonconsulting.github.io/universals/reference/esr.html)
    and
    [`rhat()`](https://poissonconsulting.github.io/universals/reference/rhat.html).
  - missing `as_df = FALSE` arg to
    [`esr()`](https://poissonconsulting.github.io/universals/reference/esr.html)
    for mcarray, mcmc and mcmc.list.
  - coercion to and from nlists objects for mcmcr, mcmc.list and mcmc
    objects.
- Moved
  - handling of terms to term package.
  - generic definitions of
    [`nchains()`](https://poissonconsulting.github.io/universals/reference/nchains.html),
    [`niters()`](https://poissonconsulting.github.io/universals/reference/niters.html),
    [`collapse_chains()`](https://poissonconsulting.github.io/universals/reference/collapse_chains.html)
    and
    [`split_chains()`](https://poissonconsulting.github.io/universals/reference/split_chains.html)
    etc to universals package.

## mcmcr 0.2.0

CRAN release: 2019-06-27

- Added
  [`check_mcmcr()`](https://poissonconsulting.github.io/mcmcr/reference/check_mcmcr.md)
  and
  [`check_mcmcarray()`](https://poissonconsulting.github.io/mcmcr/reference/check_mcmcarray.md).
- Fixed by and as_df arguments in
  [`converged()`](https://poissonconsulting.github.io/universals/reference/converged.html).
- Added more tests.
- Removed `as.mcmc.mcmc.list()`, `thin.mcmc()` and `thin.mcmc.list()` as
  now defined by coda.
- No longer export `as.mcmc.list.mcarray()` as clashes with rjags
  version.

## mcmcr 0.1.0

CRAN release: 2019-04-26

- Added
  [`mcmc_aperm()`](https://poissonconsulting.github.io/mcmcr/reference/mcmc_aperm.md)
  function to transpose parameter dimensions.
- Added
  [`npdims()`](https://poissonconsulting.github.io/universals/reference/npdims.html)
  function to get number of parameter dimensions.
- Added `by = TRUE` argument to
  [`mcmc_map()`](https://poissonconsulting.github.io/mcmcr/reference/mcmc_map.md)
  function.
- Removed tibble package from suggests.
- [`rhat()`](https://poissonconsulting.github.io/universals/reference/rhat.html)
  now returns minimum of 1.
- Defined
  [`subset()`](https://poissonconsulting.github.io/mcmcr/reference/subset.md)
  and
  [`parameters()`](https://poissonconsulting.github.io/term/reference/deprecated.html)
  for mcmcrs object.
- Added `bound = FALSE` argument to
  [`rhat.mcmcrs()`](https://poissonconsulting.github.io/mcmcr/reference/rhat.mcmcrs.md)
  and
  [`converged.mcmcrs()`](https://poissonconsulting.github.io/mcmcr/reference/converged.mcmcrs.md)
  functions.

## mcmcr 0.0.3

CRAN release: 2018-11-24

- Moved graphics, coef, tibble packages from imports to suggests.
- Replaced internal `error()` with `err::err()`.

## mcmcr 0.0.2

CRAN release: 2018-10-30

- Allowed NAs in values to calculate pvalues.
- Updated to not use length argument in checkr as deprecated.

## mcmcr 0.0.1

CRAN release: 2018-04-13

- Released to CRAN.
