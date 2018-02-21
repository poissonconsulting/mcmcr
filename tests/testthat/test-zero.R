context("zero")

test_that("zero.mcmcarray", {
  mcmcarray <- mcmcr_example[[2]]

  expect_identical(estimates(zero(mcmcarray)), matrix(0, nrow = 2, ncol = 2))
})

test_that("zero.mcmcr", {
  mcmcr0 <- zero(mcmcr_example, parameters = "sigma")
  expect_identical(estimates(mcmcr0)$sigma, 0)
  expect_identical(estimates(mcmcr0)$beta, estimates(mcmcr_example)$beta)
})
