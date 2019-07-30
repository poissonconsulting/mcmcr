context("term")

test_that("as.mcmcr with irregular names", {
  mcmcr <- subset(mcmcr::mcmcr_example, chains = 1L)
  mcmc <- coda::as.mcmc(mcmcr)
  colnames(mcmc) <- sub("alpha", "al.pha", colnames(mcmc))
  colnames(mcmc) <- sub("beta", "beta_", colnames(mcmc))
  expect_identical(coda::as.mcmc(as.mcmcr(mcmc)), mcmc)
})
