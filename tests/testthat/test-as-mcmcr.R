context("as-mcmcr")

test_that("as.mcmcr", {
  expect_identical(as.mcmcr(unclass(mcmcr_example)), mcmcr_example)
  expect_identical(as.mcmcr(mcmcr_example), mcmcr_example)
  expect_is(as.mcmcr(as.mcarray(mcmcr_example$beta)), "mcmcr")
  expect_is(as.mcmcr(mcmcr_example$beta), "mcmcr")
})

test_that("as.mcmcr.mcmc", {
  mcmcr <- subset(mcmcr::mcmcr_example, chains = 1L)
  expect_identical(as.mcmcr(coda::as.mcmc(mcmcr)), mcmcr)

  mcmc <- coda::as.mcmc(mcmcr)
  mcmc <- mcmc[,c("alpha[2]", "beta[1,1]", "beta[2,1]", "beta[2,2]", "sigma")]
  mcmc2 <- coda::as.mcmc(as.mcmcr(mcmc))

  mcmc2 <- mcmc2[,c("alpha[2]", "beta[1,1]", "beta[2,1]", "beta[2,2]", "sigma")]
  expect_identical(mcmc2, mcmc)
})
