context("parameters")

test_that("parameters", {
  expect_equal(parameters(mcmcr), c("alpha", "beta", "sigma"))
  parameters(mcmcr) <- c("alpha1", "alpha2", "alpha3")
  expect_equal(parameters(mcmcr), c("alpha1", "alpha2", "alpha3"))
})
