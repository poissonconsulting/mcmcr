context("convergence")

test_that("convergence.mcmcmarray", {
  expect_identical(convergence(mcmcr[[1]]), c(1.01, 1.00))
  expect_identical(convergence(mcmcr[[2]]), matrix(1.00, nrow = 2, ncol = 2))
  expect_identical(convergence(mcmcr[[3]]), c(1.01))
})

test_that("convergence.mcmcr", {
  expect_identical(convergence(mcmcr), 1.01)
})
