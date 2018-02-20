context("bind_parameters")

test_that("bind_parameters", {
  expect_identical(parameters(bind_parameters(subset(coda::as.mcmc.list(mcmcr_example), parameter = "beta"), subset(coda::as.mcmc.list(mcmcr_example), parameter = "alpha"))), c("beta", "alpha"))
  expect_identical(parameters(bind_parameters(subset(mcmcr_example, parameter = "beta"), subset(mcmcr_example, parameter = "alpha"))), c("beta", "alpha"))
})
