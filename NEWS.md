<!-- NEWS.md is maintained by https://fledge.cynkra.com, contributors should not edit this file -->

# mcmcr 0.6.1.9002

- Provide soft deprecated message on breaking change.

# mcmcr 0.6.1.9001

- When `bound = TRUE` `rhat()` now also returns rhat values for separate analyses.

- When `bound = TRUE` and `as_df = TRUE` `rhat()` now returns a data.frame with the rhat values for the separate and combined analyses.

- Merge pull request #52 from poissonconsulting/description-contr.

add contributors

- Merge pull request #50 from poissonconsulting/rcmd-check.

update rcmd check and documentation

- Merge pull request #49 from poissonconsulting/changes_to_actions.

Made changes to Actions using UsePois and Files were created


# mcmcr 0.6.1.9000

- Same as previous version.


# mcmcr 0.6.1

- Update testing to testthat 3.

# mcmcr 0.6.0

- Added `fill_na()` for `mcarray`, `mcmcarray` and `mcmcr`.
- Fixed `as.mcmcarray.mcmc()` (and `as.mcmcr.mcmc()`) so now returns an `mcmcarray` (and `mcmcr`) object with no terms.

# mcmcr 0.5.0

- Added 
  - `tidy.mcmcr()`.
  - `simplify = FALSE` argument to `coef()` and `tidy()` and soft-deprecated if not `TRUE`.
  - `...` optional arguments for `fun = median` argument to `estimates()`.
- Moved `as_nlists.mcmc.list()` to nlist package.

# mcmcr 0.4.0

- Added `as_mcmc_list.mcmr()`.
- Moved the following to `nlist` 
  - `as_nlist.mcmc()` and `as_nlist.mcmc.list()`
  - `as_nlists.mcmc()`
  - `as.term.mcmc()` and `as.term.mcmc.list()`
  - `bind_iterations.mcmc()` and `bind_iterations.mcmc.list()`
  - `collapse_chains.default()` and `collapse_chains.mcmc.list()`

# mcmcr 0.3.0

- Changed
  - `npdims.mcmc.list()` to return character vector (as opposed to list)
  - `collapse_chains.mcmc.list()` to return an mcmc.list object with one chain (as opposed to an mcmc object)
  - first argument of `estimates()` from `object` to `x`.
  - `scalar_only = FALSE ` argument of `pars()` to `scalar = NA`.
  - `estimates()` so now checks fun returns scalar numeric.

- Soft-deprecated 
  - `pvalue()` for `extras::pvalue()`.
  - `zero()` for `fill_all()`.
  - `check_mcmcarray()` and `check_mcmcr()` for `chk_mcmcarray()` and `chk_mcmcr()`.
  - `iterations` argument with `iters` in `subset()`.
  - `parameters` argument with `pars` in `subset()`.

- Added 
  - `vld_()` and `chk_()` functions for mcmcarray and mcmcr objects.
  - `scalar = NULL` argument to `pars()` and `npars()`.
  - `na_rm = NA` argument to `esr()` and `rhat()`.
  - missing `as_df = FALSE` arg to `esr()` for mcarray, mcmc and mcmc.list.
  - coercion to and from nlists objects for mcmcr, mcmc.list and mcmc objects.

- Moved
  - handling of terms to term package.
  - generic definitions of `nchains()`, `niters()`, `collapse_chains()` and `split_chains()` etc to universals package.

# mcmcr 0.2.0

- Added `check_mcmcr()` and `check_mcmcarray()`.
- Fixed by and as_df arguments in `converged()`.
- Added more tests.
- Removed `as.mcmc.mcmc.list()`, `thin.mcmc()` and `thin.mcmc.list()` as now defined by coda.
- No longer export `as.mcmc.list.mcarray()` as clashes with rjags version.

# mcmcr 0.1.0

- Added `mcmc_aperm()` function to transpose parameter dimensions.
- Added `npdims()` function to get number of parameter dimensions.
- Added `by = TRUE` argument to `mcmc_map()` function.
- Removed tibble package from suggests.
- `rhat()` now returns minimum of 1.
- Defined `subset()` and `parameters()` for mcmcrs object.
- Added `bound = FALSE` argument to `rhat.mcmcrs()` and `converged.mcmcrs()` functions.

# mcmcr 0.0.3

- Moved graphics, coef, tibble packages from imports to suggests.
- Replaced internal `error()` with `err::err()`.

# mcmcr 0.0.2

- Allowed NAs in values to calculate pvalues.
- Updated to not use length argument in checkr as deprecated.

# mcmcr 0.0.1

- Released to CRAN.
