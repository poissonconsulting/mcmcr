context("nchains")

test_that("nchains", {
  expect_identical(nchains(as.mcmc.list(mcmcr_example)), 2L)
  expect_identical(nchains(mcmcr_example), 2L)
})
