context("esr")

test_that("esr.matrix", {
  matrix <- matrix(1, nrow = 2, ncol = 100)
  expect_identical(esr(matrix), 1)
  matrix[1,] <- 2
  expect_identical(esr(matrix), 1)
  matrix[1,1] <- NA
  expect_error(esr(matrix))
})

test_that("esr.mcmcmarray", {
  expect_identical(esr(mcmcr[[1]], by = "term"), c(0.82, 0.82))
  expect_equivalent(esr(mcmcr[[2]], by = "term"), matrix(c(0, 0, 0, 0), nrow = 2, ncol = 2))
  expect_identical(esr(mcmcr[[3]], by = "term"), c(0.37))
  expect_identical(esr(mcmcr[[2]]), 0)
  expect_identical(esr(mcmcr[[1]], "parameter"), esr(mcmcr[[1]], "all"))
})

test_that("esr.mcmcr", {
  expect_identical(esr(mcmcr), 0)
  expect_identical(esr(mcmcr, by = "parameter"), list(alpha = 0.82, beta = 0, sigma = 0.37))
  expect_equivalent(esr(mcmcr, by = "term"), list(alpha = c(0.82, 0.82), beta = matrix(c(0, 0, 0, 0), nrow = 2, ncol = 2), sigma = 0.37))
})

test_that("esr.mcmcrs", {
  expect_identical(esr(mcmcrs_example), list(mcmcr1 = 0, mcmcr2 = 0))
})

