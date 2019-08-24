context("collapse_chains")

test_that("collapse_chains", {
  x <- subset(mcmcr::mcmcr_example, iters = 1:3)
  expect_is(collapse_chains(coda::as.mcmc.list(x)), "mcmc.list")
  expect_identical(nchains(collapse_chains(as.mcmc.list(mcmcr_example))), 1L)
  expect_identical(nchains(collapse_chains(mcmcr_example)), 1L)
  expect_identical(nchains(collapse_chains(mcmcr_example2)), 1L)
})
