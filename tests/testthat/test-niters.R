context("niters")

test_that("niters", {
  expect_identical(niters(coda::as.mcmc.list(mcmcr_example)), 400L)
  expect_identical(niters(mcmcr_example), 400L)
})
