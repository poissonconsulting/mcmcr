context("as-mcmcarray")

test_that("as.mcmcarray",{
  expect_error(as.mcmcarray(as.mcmc(subset(mcmcr::mcmcr_example, chains = 1L))),
               "x must only have 1 parameter")
})
