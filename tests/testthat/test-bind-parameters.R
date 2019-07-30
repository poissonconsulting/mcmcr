context("bind_parameters")

test_that("bind_parameters", {
  expect_identical(pars(bind_parameters(subset(as.mcmc.list(mcmcr_example), pars = "beta"), subset(as.mcmc.list(mcmcr_example), pars = "alpha"))), c("alpha", "beta"))
  expect_identical(pars(bind_parameters(subset(mcmcr_example, pars = "beta"), subset(mcmcr_example, pars = "alpha"))), c("alpha", "beta"))
  expect_identical(pars(bind_parameters(subset(mcmcr_example2, pars = "beta"), subset(mcmcr_example2, pars = "alpha"))), c("alpha", "beta"))
})
