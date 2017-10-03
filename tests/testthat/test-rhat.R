context("rhat")

test_that("rhat.mcmcmarray", {
  expect_identical(rhat(mcmcr[[1]], by = "term"), c(1, 1))
  expect_equivalent(rhat(mcmcr[[2]], by = "term"), matrix(c(1.85, 1.85, 1.87, 1.87), nrow = 2, ncol = 2))
  expect_identical(rhat(mcmcr[[3]], by = "term"), c(1))
  expect_identical(rhat(mcmcr[[2]]), c(1.87))
  expect_identical(rhat(mcmcr[[1]], "parameter"), rhat(mcmcr[[1]], "all"))
})

test_that("rhat.mcmcr", {
  expect_identical(rhat(mcmcr), 1.87)
  expect_identical(rhat(mcmcr, by = "parameter"), list(alpha = 1, beta = 1.87, sigma = 1))
  expect_equivalent(rhat(mcmcr, by = "term"), list(alpha = c(1, 1), beta = matrix(c(1.85, 1.85, 1.87, 1.87), nrow = 2, ncol = 2), sigma = 1))
})

