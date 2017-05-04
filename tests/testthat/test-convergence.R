context("rhat")

test_that("rhat.mcmcmarray", {
  expect_identical(rhat(mcmcr[[1]], by = "term"), c(1.01, 1.00))
  expect_identical(rhat(mcmcr[[2]], by = "term"), matrix(1.00, nrow = 2, ncol = 2))
  expect_identical(rhat(mcmcr[[3]], by = "term"), c(1.01))
  expect_identical(rhat(mcmcr[[1]]), c(1.01))
  expect_identical(rhat(mcmcr[[1]], "parameter"), rhat(mcmcr[[1]], "all"))
})

test_that("rhat.mcmcr", {
  expect_identical(rhat(mcmcr), 1.01)
  expect_identical(rhat(mcmcr, by = "parameter"), list(alpha = 1.01, beta = 1.0, sigma = 1.01))
  expect_identical(rhat(mcmcr, by = "term"), list(alpha = c(1.01, 1.00), beta = matrix(1.00, nrow = 2, ncol = 2), sigma = 1.01))
})
