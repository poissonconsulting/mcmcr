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
  expect_identical(esr(mcmcr::mcmcr_example[[1]], by = "term"), c(1, 1))
  expect_equivalent(esr(mcmcr::mcmcr_example[[2]], by = "term"), matrix(c(0.81, 0.81, 0.81, 0.81), nrow = 2, ncol = 2))
  expect_identical(esr(mcmcr::mcmcr_example[[3]], by = "term"), c(0.46))
  expect_identical(esr(mcmcr::mcmcr_example[[2]]), 0.81)
  expect_identical(esr(mcmcr::mcmcr_example[[2]], "parameter"), esr(mcmcr::mcmcr_example[[2]], "all"))
})

test_that("esr.mcmcr", {
  expect_identical(esr(mcmcr::mcmcr_example), 0.46)
  expect_identical(esr(mcmcr::mcmcr_example, by = "parameter"), list(alpha = 1, beta = 0.81, sigma = 0.46))
  expect_equivalent(esr(mcmcr::mcmcr_example, by = "term"), list(alpha = c(1, 1), beta = matrix(c(0.81, 0.81, 0.81, 0.81), nrow = 2, ncol = 2), sigma = 0.46))
})

test_that("esr.mcmcrs", {
  expect_identical(esr(mcmcrs(mcmcr::mcmcr_example, mcmcr::mcmcr_example)), list(mcmcr1 = 0.46, mcmcr2 = 0.46))
})

