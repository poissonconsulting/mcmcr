test_that(".esr_numeric", {
  vector <- rep(1, 100)
  expect_identical(.esr_numeric(vector, na_rm = FALSE), 1)
  vector <- rep(2, 100)
  expect_identical(.esr_numeric(vector, na_rm = FALSE), 1)
  vector[1] <- NA
  expect_true(is.na(.esr_numeric(vector, na_rm = FALSE)))
  expect_identical(.esr_numeric(vector, na_rm = TRUE), 1)
  expect_equal(.esr_numeric(1:10, na_rm = FALSE), 0.284, tolerance = 0.00001)
})

test_that("esr.matrix", {
  matrix <- matrix(1, nrow = 2, ncol = 1000)
  expect_identical(.esr(matrix, na_rm = FALSE), 1)
  matrix[1,] <- 2
  expect_identical(.esr(matrix, na_rm = FALSE), 1)
  matrix[1,1] <- NA
  expect_true(is.na(.esr_numeric(matrix, na_rm = FALSE)))
  expect_identical(.esr_numeric(matrix, na_rm = TRUE), 1)
})

test_that("esr.mcmcmarray", {
  expect_identical(esr(mcmcr_example[[1]], by = "term"), c(0.011, 0.011))
  expect_equivalent(esr(mcmcr_example[[2]], by = "term"), matrix(c(0.05, 0.05, 0.05, 0.05), nrow = 2, ncol = 2))
  expect_identical(esr(mcmcr_example[[2]], by = "term", as_df = TRUE), tibble(term = as_term(c("parameter[1,1]", "parameter[2,1]", "parameter[1,2]", "parameter[2,2]")), esr = rep(0.05, 4)))
  expect_identical(esr(mcmcr_example[[3]], by = "term"), c(0.472))
  expect_identical(esr(mcmcr_example[[3]], by = "term", as_df = TRUE), tibble(term = as_term("parameter"), esr = 0.472))
  expect_identical(esr(mcmcr_example[[2]]), 0.05)
  expect_identical(esr(mcmcr_example[[2]], "parameter"), esr(mcmcr_example[[2]], "all"))
  expect_identical(esr(subset(mcmcr_example[[2]], iters = 1L), by = "term", as_df = TRUE), tibble(term = as_term(c("parameter[1,1]", "parameter[2,1]", "parameter[1,2]", "parameter[2,2]")), esr = rep(1, 4)))
})

test_that("esr.mcarray", {
  mcarray <- as.mcarray(mcmcr::mcmcr_example[[2]])
  expect_identical(esr(mcarray), 0.05)
  expect_identical(esr(mcarray, as_df = TRUE), tibble(parameter = "parameter", esr = 0.05))
  expect_identical(esr(mcarray, by = "parameter"), 0.05)
  expect_equivalent(esr(mcarray, by = "term"), matrix(c(0.05, 0.05, 0.05, 0.05)))
  expect_equivalent(esr(mcarray, by = "term", as_df = TRUE), tibble(term = as_term(c("parameter[1,1]", "parameter[2,1]", "parameter[1,2]", "parameter[2,2]")), esr = c(0.05, 0.05, 0.05, 0.05)))
})

test_that("esr.mcmc", {
  mcmc <- as.mcmc(subset(mcmcr::mcmcr_example, chains = 2L))
  expect_identical(esr(mcmc), 0.01)
  expect_identical(esr(mcmc, as_df = TRUE), tibble(all = "all", esr = 0.01))
  expect_identical(esr(mcmc, by = "parameter"), list(alpha = 0.01, beta = 0.062, sigma = 0.474))
  expect_equivalent(esr(mcmc, by = "term"), list(alpha = c(0.01, 0.01), beta = matrix(c(0.062, 0.062, 0.062, 0.062), nrow = 2, ncol = 2), sigma = 0.474))
  expect_equivalent(esr(mcmc, by = "term", as_df = TRUE), tibble(term = as_term(c("alpha[1]", "alpha[2]", "beta[1,1]", "beta[2,1]", "beta[1,2]", "beta[2,2]", "sigma")), esr = c(0.01, 0.01, 0.062, 0.062, 0.062, 0.062, 0.474)))
})

test_that("esr.mcmc.list", {
  expect_identical(esr(as.mcmc.list(mcmcr::mcmcr_example)), 0.011)
  expect_identical(esr(as.mcmc.list(mcmcr::mcmcr_example), as_df = TRUE), tibble(all = "all", esr = 0.011))
  expect_identical(esr(as.mcmc.list(mcmcr::mcmcr_example), by = "parameter"), list(alpha = 0.011, beta = 0.05, sigma = 0.472))
  expect_equivalent(esr(as.mcmc.list(mcmcr::mcmcr_example), by = "term"), list(alpha = c(0.011, 0.011), beta = matrix(c(0.05, 0.05, 0.05, 0.05), nrow = 2, ncol = 2), sigma = 0.472))
  expect_equivalent(esr(as.mcmc.list(mcmcr::mcmcr_example), by = "term", as_df = TRUE), tibble(term = as_term(c("alpha[1]", "alpha[2]", "beta[1,1]", "beta[2,1]", "beta[1,2]", "beta[2,2]", "sigma")), esr = c(0.011, 0.011, 0.05, 0.05, 0.05, 0.05, 0.472)))
})


test_that("esr.mcmcr", {
  expect_identical(esr(mcmcr_example2), 0.011)
  expect_identical(esr(mcmcr_example), 0.011)
  expect_identical(esr(mcmcr_example, as_df = TRUE), tibble(all = "all", esr = 0.011))
  expect_identical(esr(mcmcr_example, by = "parameter"), list(alpha = 0.011, beta = 0.05, sigma = 0.472))
  expect_equivalent(esr(mcmcr_example, by = "term"), list(alpha = c(0.011, 0.011), beta = matrix(c(0.05, 0.05, 0.05, 0.05), nrow = 2, ncol = 2), sigma = 0.472))
  expect_equivalent(esr(mcmcr_example, by = "term", as_df = TRUE), tibble(term = as_term(c("alpha[1]", "alpha[2]", "beta[1,1]", "beta[2,1]", "beta[1,2]", "beta[2,2]", "sigma")), esr = c(0.011, 0.011, 0.05, 0.05, 0.05, 0.05, 0.472)))
})

test_that("esr.mcmcr NA", {
  x <- mcmcr:::mcmcr_example2
  x$alpha[1,1,1,1,1] <- NA_real_
  expect_identical(esr(x), NA_real_)
  expect_identical(esr(x, na_rm = TRUE), 0.011)
  expect_identical(esr(x, by = "parameter"), list(alpha = NA_real_, beta = 0.05, sigma = 0.472))
  expect_identical(esr(x, by = "parameter", na_rm = TRUE), list(alpha = 0.011, beta = 0.05, sigma = 0.472))
})

test_that("esr.mcmcrs", {
  expect_identical(esr(mcmcrs(mcmcr_example, mcmcr_example)), list(mcmcr1 = 0.011, mcmcr2 = 0.011))
})
