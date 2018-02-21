context("esr")

test_that("esr.numeric", {
  vector <- rep(1, 100)
  expect_identical(esr(vector), 1)
  vector <- rep(2, 100)
  expect_identical(esr(vector), 1)
  vector[1] <- NA
  expect_error(esr(vector))
  expect_identical(esr(1:10), 0.28)
})

test_that("esr.matrix", {
  matrix <- matrix(1, nrow = 2, ncol = 1000)
  expect_identical(esr(matrix), 1)
  matrix[1,] <- 2
  expect_identical(esr(matrix), 1)
  matrix[1,1] <- NA
  expect_error(esr(matrix))
})

test_that("esr.mcmcmarray", {
  expect_identical(esr(mcmcr_example[[1]], by = "term"), c(0.01, 0.01))
  expect_equivalent(esr(mcmcr_example[[2]], by = "term"), matrix(c(0.05, 0.05, 0.05, 0.05), nrow = 2, ncol = 2))
  expect_identical(esr(mcmcr_example[[3]], by = "term"), c(0.47))
  expect_identical(esr(mcmcr_example[[2]]), 0.05)
  expect_identical(esr(mcmcr_example[[2]], "parameter"), esr(mcmcr_example[[2]], "all"))
})

test_that("esr.mcmcr", {
  expect_identical(esr(mcmcr_example2), 0.01)
  expect_identical(esr(mcmcr_example), 0.01)
  expect_identical(esr(mcmcr_example, by = "parameter"), list(alpha = 0.01, beta = 0.05, sigma = 0.47))
  expect_equivalent(esr(mcmcr_example, by = "term"), list(alpha = c(0.01, 0.01), beta = matrix(c(0.05, 0.05, 0.05, 0.05), nrow = 2, ncol = 2), sigma = 0.47))
})

test_that("esr.mcmcrs", {
  expect_identical(esr(mcmcrs(mcmcr_example, mcmcr_example)), list(mcmcr1 = 0.01, mcmcr2 = 0.01))
})

