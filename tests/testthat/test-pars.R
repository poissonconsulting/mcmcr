context("pars")

test_that("pars.mcmcr", {
  expect_equal(pars(mcmcr_example), c("alpha", "beta", "sigma"))
  expect_equal(pars(mcmcr_example, scalar_only = TRUE), c("sigma"))
  pars(mcmcr_example) <- c("alpha1", "alpha2", "alpha3")
  expect_equal(pars(mcmcr_example), c("alpha1", "alpha2", "alpha3"))
})

test_that("pars.mcmcrs", {
  mcmcrs <- mcmcrs(mcmcr::mcmcr_example, mcmcr::mcmcr_example)
  expect_equal(pars(mcmcrs), c("alpha", "beta", "sigma"))
  expect_equal(pars(mcmcrs, scalar_only = TRUE), c("sigma"))
  pars(mcmcrs) <- c("alpha1", "alpha2", "alpha3")
  expect_equal(pars(mcmcrs), c("alpha1", "alpha2", "alpha3"))
})
