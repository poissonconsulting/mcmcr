context("rhat")

test_that("rhat.mcmcmarray", {
  expect_identical(rhat(mcmcr[[1]]), c(1.01, 1.00))
  expect_identical(rhat(mcmcr[[2]]), matrix(1.00, nrow = 2, ncol = 2))
  expect_identical(rhat(mcmcr[[3]]), c(1.01))
})

test_that("rhat.mcmcr", {
  expect_identical(rhat(mcmcr), 1.01)

  mcmcr[[1]] <- zero(mcmcr[[1]])
  mcmcr[[3]] <- zero(mcmcr[[3]])

  expect_identical(rhat(mcmcr[[1]]), c(1.00, 1.00))
  expect_identical(rhat(mcmcr[[3]]), 1.00)

  expect_identical(rhat(mcmcr), 1.00)
})
