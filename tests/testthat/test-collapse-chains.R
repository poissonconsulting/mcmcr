context("collapse_chains")

test_that("collapse_chains.mcmcarray", {
  expect_is(collapse_chains(as.mcmc.list(mcmcr_example)), "mcmc")
  expect_identical(nchains(collapse_chains(as.mcmc.list(mcmcr_example))), 1L)
  expect_identical(nchains(collapse_chains(mcmcr_example)), 1L)
  expect_identical(nchains(collapse_chains(mcmcr_example2)), 1L)
})
