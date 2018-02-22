context("zero")

test_that("zero.mcmcarray", {
  mcmcarray <- mcmcr_example[[2]]
  expect_equal(estimates(zero(mcmcarray)), matrix(0, nrow = 2, ncol = 2), check.attributes = FALSE)
})

test_that("zero.mcmcr", {
  mcmcr0 <- zero(mcmcr_example, parameters = "sigma")
  expect_identical(estimates(mcmcr0)$sigma, 0)
  expect_identical(estimates(mcmcr0)$beta, estimates(mcmcr_example)$beta)
})

test_that("zero.mcmcr2", {
  mcmcr0 <- zero(mcmcr_example2, parameters = "beta")
  expect_true(all(estimates(mcmcr0)$beta == 0))
  expect_identical(pdims(mcmcr0), pdims(mcmcr_example2))
  expect_identical(estimates(mcmcr0)$sigma, estimates(mcmcr_example2)$sigma)
})

