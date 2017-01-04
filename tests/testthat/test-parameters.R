context("parameters")

test_that("parameters", {
  expect_equal(parameters(mcmcr), c("alpha", "beta", "sigma"))
})
