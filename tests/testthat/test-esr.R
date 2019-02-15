context("esr")

test_that(".esr_numeric", {
  vector <- rep(1, 100)
  expect_identical(.esr_numeric(vector), 1)
  vector <- rep(2, 100)
  expect_identical(.esr_numeric(vector), 1)
  vector[1] <- NA
  expect_error(.esr_numeric(vector))
  expect_equal(.esr_numeric(1:10), 0.284, tolerance = 0.00001)
})

test_that("esr.matrix", {
  matrix <- matrix(1, nrow = 2, ncol = 1000)
  expect_identical(.esr(matrix), 1)
  matrix[1,] <- 2
  expect_identical(.esr(matrix), 1)
  matrix[1,1] <- NA
  expect_error(.esr(matrix))
})

test_that("esr.mcmcmarray", {
  expect_identical(esr(mcmcr_example[[1]], by = "term"), c(0.011, 0.011))
  expect_equivalent(esr(mcmcr_example[[2]], by = "term"), matrix(c(0.05, 0.05, 0.05, 0.05), nrow = 2, ncol = 2))
  expect_identical(esr(mcmcr_example[[2]], by = "term", as_df = TRUE), tibble(term = as.term(c("parameter[1,1]", "parameter[2,1]", "parameter[1,2]", "parameter[2,2]")), esr = rep(0.05, 4)))
  expect_identical(esr(mcmcr_example[[3]], by = "term"), c(0.472))
  expect_identical(esr(mcmcr_example[[3]], by = "term", as_df = TRUE), tibble(term = as.term("parameter"), esr = 0.472))
  expect_identical(esr(mcmcr_example[[2]]), 0.05)
  expect_identical(esr(mcmcr_example[[2]], "parameter"), esr(mcmcr_example[[2]], "all"))
  expect_identical(esr(subset(mcmcr_example[[2]], iterations = 1L), by = "term", as_df = TRUE), tibble(term = as.term(c("parameter[1,1]", "parameter[2,1]", "parameter[1,2]", "parameter[2,2]")), esr = rep(1, 4)))
})

test_that("esr.mcmcr", {
  expect_identical(esr(mcmcr_example2), 0.011)
  expect_identical(esr(mcmcr_example), 0.011)
  expect_identical(esr(mcmcr_example, as_df = TRUE), tibble(all = "all", esr = 0.011))
  expect_identical(esr(mcmcr_example, by = "parameter"), list(alpha = 0.011, beta = 0.05, sigma = 0.472))
  expect_equivalent(esr(mcmcr_example, by = "term"), list(alpha = c(0.011, 0.011), beta = matrix(c(0.05, 0.05, 0.05, 0.05), nrow = 2, ncol = 2), sigma = 0.472))
  expect_equivalent(esr(mcmcr_example, by = "term", as_df = TRUE), tibble(term = as.term(c("alpha[1]", "alpha[2]", "beta[1,1]", "beta[2,1]", "beta[1,2]", "beta[2,2]", "sigma")), esr = c(0.011, 0.011, 0.05, 0.05, 0.05, 0.05, 0.472)))
})

test_that("esr.mcmcrs", {
  expect_identical(esr(mcmcrs(mcmcr_example, mcmcr_example)), list(mcmcr1 = 0.011, mcmcr2 = 0.011))
})
