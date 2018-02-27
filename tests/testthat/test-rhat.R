context("rhat")

test_that("rhat.matrix", {
  matrix <- matrix(1, nrow = 2, ncol = 100)
  expect_identical(.rhat(matrix), 1)
  matrix[1,] <- 2
  expect_true(is.infinite(.rhat(matrix)))
    matrix[1,1] <- NA
  expect_true(is.na(.rhat(matrix)))
})

test_that("rhat.mcmcmarray", {
  expect_identical(rhat(mcmcr_example[[1]], by = "term"), c(2.002, 2.002))

  expect_equivalent(rhat(mcmcr_example[[2]], by = "term"), matrix(c(1.147, 1.147, 1.147, 1.147), nrow = 2, ncol = 2))
  expect_identical(rhat(mcmcr_example[[3]], by = "term"), c(0.998))
  expect_identical(rhat(mcmcr_example[[2]]), 1.147)
  expect_identical(rhat(mcmcr_example[[2]], as_df = TRUE), tibble::tibble(parameter = "parameter", rhat = 1.147))
  expect_identical(rhat(mcmcr_example[[2]], by = "term", as_df = TRUE), tibble::tibble(term = as.term(c("parameter[1,1]", "parameter[2,1]", "parameter[1,2]", "parameter[2,2]")), rhat = rep(1.147, 4)))

  expect_identical(rhat(subset(mcmcr_example[[2]], iterations = 1L), by = "term", as_df = TRUE), tibble::tibble(term = as.term(c("parameter[1,1]", "parameter[2,1]", "parameter[1,2]", "parameter[2,2]")), rhat = rep(NA_real_, 4)))
  expect_identical(rhat(mcmcr_example[[1]], "parameter"), rhat(mcmcr_example[[1]], "all"))
})

test_that("rhat.mcmcr", {
  expect_identical(rhat(mcmcr_example2), 2.002)
  expect_identical(rhat(mcmcr_example), 2.002)
  expect_identical(rhat(mcmcr_example, by = "parameter"), list(alpha = 2.002, beta = 1.147, sigma = 0.998))
  expect_equal(rhat(mcmcr_example, by = "parameter", as_df = TRUE), tibble::tibble(parameter = c("alpha", "beta", "sigma"), rhat = c(2.002, 1.147, 0.998)), check.attributes = FALSE)
  expect_equivalent(rhat(mcmcr_example, by = "term"), list(alpha = c(2.002, 2.002), beta = matrix(c(1.147, 1.147, 1.147, 1.147), nrow = 2.002, ncol = 2), sigma = 0.998))
  expect_equivalent(rhat(mcmcr_example, by = "term", as_df = TRUE), tibble::tibble(term = as.term(c("alpha[1]", "alpha[2]", "beta[1,1]", "beta[2,1]", "beta[1,2]", "beta[2,2]", "sigma")), rhat = c(2.002, 2.002, 1.147, 1.147, 1.147, 1.147, 0.998)))
})

test_that("rhat.mcmcrs", {
  expect_identical(rhat(mcmcrs(mcmcr_example, mcmcr_example)), list(mcmcr1 = 2.002, mcmcr2 = 2.002))
  expect_identical(rhat(mcmcrs(mcmcr_example, mcmcr_example), by = "parameter"),
                   list(mcmcr1 = list(alpha = 2.002, beta = 1.147, sigma = 0.998),
                        mcmcr2 = list(alpha = 2.002, beta = 1.147, sigma = 0.998)))
})
