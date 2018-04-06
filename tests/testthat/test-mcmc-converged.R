context("mcmc_converged")

test_that("mcmc_converged", {
  expect_false(mcmc_converged(mcmcr_example))
  expect_false(mcmc_converged(mcmcr_example2))
  expect_true(mcmc_converged(mcmcr_example$sigma))
})
