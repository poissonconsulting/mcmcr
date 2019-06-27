# mcmcr 0.2.0

- Added check_mcmcr() and check_mcmcarray().
- Fixed by and as_df arguments in converged().
- Added more tests.
- Removed as.mcmc.mcmc.list(), thin.mcmc() and thin.mcmc.list() as now defined by coda.
- No longer export as.mcmc.list.mcarray() as clashes with rjags version.

# mcmcr 0.1.0

- Added mcmc_aperm() function to transpose parameter dimensions.
- Added npdims() function to get number of parameter dimensions.
- Added by = TRUE argument to mcmc_map() function.
- Removed tibble from suggests.
- rhat now returns minimum of 1.
- Defined subset and parameters for mcmcrs object.
- Added bound = FALSE argument to rhat.mcmcrs() and converged.mcmcrs() functions.

# mcmcr 0.0.3

- Moved graphics, coef, tibble from imports to suggests.
- Replaced internal error() with err::err().

# mcmcr 0.0.2

- Allowed NAs in values to calculate pvalues.
- Updated to not use length argument in checkr as deprecated.

# mcmcr 0.0.1

- Released to CRAN.
