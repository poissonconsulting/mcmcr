context("bind_parameters")

test_that("bind_parameters", {
  expect_identical(parameters(bind_parameters(subset(as.mcmc.list(mcmcr_example), parameter = "beta"), subset(as.mcmc.list(mcmcr_example), parameter = "alpha"))), c("alpha", "beta"))
  expect_identical(parameters(bind_parameters(subset(mcmcr_example, parameter = "beta"), subset(mcmcr_example, parameter = "alpha"))), c("alpha", "beta"))
  expect_identical(parameters(bind_parameters(subset(mcmcr_example2, parameter = "beta"), subset(mcmcr_example2, parameter = "alpha"))), c("alpha", "beta"))
})
