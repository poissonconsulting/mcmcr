test_that("complete_terms", {
  mcmc <- coda::as.mcmc(subset(mcmcr_example, chains = 1L))
  expect_identical(complete_terms(mcmc), mcmc)
  mcmc[, "beta[1,2]"] <- NA
  expect_identical(complete_terms(mcmc), mcmc)
  mcmc2 <- mcmc
  mcmc2 <- mcmc2[, -5]
  expect_identical(complete_terms(mcmc2), mcmc)
})
