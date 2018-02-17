context("parameters")

test_that("parameters.term", {
  parameters(as.term("beta[1,1]"), "beta")
})

test_that("parameters", {
  expect_equal(parameters(mcmcr), c("alpha", "beta", "sigma"))
  expect_equal(parameters(mcmcr, scalar_only = TRUE), c("sigma"))
  parameters(mcmcr) <- c("alpha1", "alpha2", "alpha3")
  expect_equal(parameters(mcmcr), c("alpha1", "alpha2", "alpha3"))

  data("line", package = "coda", envir = environment())
  expect_identical(parameters(line[[1]]), c("alpha", "beta", "sigma"))
  expect_identical(parameters(line[[1]], scalar_only = TRUE), c("alpha", "beta", "sigma"))
  expect_identical(parameters(line), c("alpha", "beta", "sigma"))
})
