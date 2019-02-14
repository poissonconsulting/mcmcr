context("rhat")

test_that("rhat.matrix", {
  matrix <- matrix(1, nrow = 2, ncol = 100)
  expect_identical(.rhat(matrix, folded = FALSE, normalized = FALSE), 1)
  matrix[1,] <- 2
  expect_true(is.infinite(.rhat(matrix, folded = FALSE, normalized = FALSE)))
  expect_true(is.infinite(.rhat(matrix, folded = FALSE, normalized = TRUE)))
  expect_identical(.rhat(matrix, folded = TRUE, normalized = TRUE), 1)
  matrix[1,1] <- NA
  expect_true(is.na(.rhat(matrix, folded = FALSE, normalized = FALSE)))
  expect_true(is.na(.rhat(matrix, folded = FALSE, normalized = TRUE)))
  expect_true(is.na(.rhat(matrix, folded = TRUE, normalized = TRUE)))

  matrix <- matrix(rep(1, 50), rep(2, 50), nrow = 1, ncol = 100)
  expect_true(is.na(.rhat(matrix, folded = TRUE, normalized = TRUE)))
  matrix[1,1] <- 1.1
  matrix[1,100] <- 2.1
  expect_true(is.na(.rhat(matrix, folded = TRUE, normalized = TRUE)))
})

test_that("rhat.mcmcmarray", {
  expect_identical(rhat(mcmcr_example[[1]], by = "term", normalized = FALSE), c(2.002, 2.002))
  expect_identical(rhat(mcmcr_example[[1]], by = "term", normalized = TRUE), c(1.413, 1.413))
  expect_identical(rhat(mcmcr_example[[1]], by = "term", folded = TRUE), c(0.998, 0.998))
  expect_identical(rhat(mcmcr_example[[1]], by = "term", folded = FALSE), c(1.413, 1.413))
  expect_identical(rhat(mcmcr_example[[1]], by = "term"), c(1.413, 1.413))

  expect_equivalent(rhat(mcmcr_example[[2]], by = "term", folded = FALSE, normalized = FALSE), matrix(c(1.147, 1.147, 1.147, 1.147), nrow = 2, ncol = 2))
  expect_equivalent(rhat(mcmcr_example[[2]], by = "term"), matrix(c(1.242, 1.240, 1.240, 1.242), nrow = 2, ncol = 2))
  expect_identical(rhat(mcmcr_example[[3]], by = "term"), 1.077)
  expect_identical(rhat(mcmcr_example[[3]], by = "term", folded = TRUE, normalized = FALSE), 0.998)
  expect_identical(rhat(mcmcr_example[[3]], by = "term", folded = TRUE, normalized = TRUE), 1.077)
  expect_identical(rhat(mcmcr_example[[3]], by = "term", folded = FALSE, normalized = TRUE), 1.03)

  expect_identical(rhat(mcmcr_example[[2]]), 1.242)
  expect_identical(rhat(mcmcr_example[[2]], normalized = FALSE, folded = FALSE), 1.147)
  expect_identical(rhat(mcmcr_example[[2]], as_df = TRUE), tibble::tibble(parameter = "parameter", rhat = 1.242))
  expect_equal(rhat(mcmcr_example[[2]], by = "term", as_df = TRUE)$term, as.term(c("parameter[1,1]", "parameter[2,1]", "parameter[1,2]", "parameter[2,2]")))
  expect_equal(rhat(mcmcr_example[[2]], by = "term", as_df = TRUE)$rhat, c(1.242, 1.240, 1.240, 1.242))

  expect_identical(rhat(subset(mcmcr_example[[2]], iterations = 1L), by = "term", as_df = TRUE)$rhat, rep(NA_real_, 4))
  expect_identical(rhat(mcmcr_example[[1]], "parameter"), rhat(mcmcr_example[[1]], "all"))
})

test_that("rhat.mcmcr", {
  expect_identical(rhat(mcmcr_example2, normalized = FALSE, folded = FALSE), 2.002)
  expect_identical(rhat(mcmcr_example, normalized = FALSE, folded = FALSE), 2.002)
  expect_identical(rhat(mcmcr_example, by = "parameter", normalized = FALSE, folded = FALSE), list(alpha = 2.002, beta = 1.147, sigma = 0.998))
  expect_equal(rhat(mcmcr_example, by = "parameter", as_df = TRUE, normalized = FALSE, folded = FALSE), tibble::tibble(parameter = c("alpha", "beta", "sigma"), rhat = c(2.002, 1.147, 0.998)), check.attributes = FALSE)
  expect_equivalent(rhat(mcmcr_example, by = "term", normalized = FALSE, folded = FALSE), list(alpha = c(2.002, 2.002), beta = matrix(c(1.147, 1.147, 1.147, 1.147), nrow = 2.002, ncol = 2), sigma = 0.998))
  expect_equivalent(rhat(mcmcr_example, by = "term", as_df = TRUE, normalized = FALSE, folded = FALSE), tibble::tibble(term = as.term(c("alpha[1]", "alpha[2]", "beta[1,1]", "beta[2,1]", "beta[1,2]", "beta[2,2]", "sigma")), rhat = c(2.002, 2.002, 1.147, 1.147, 1.147, 1.147, 0.998)))
})

test_that("rhat.mcmcrs", {
  expect_identical(rhat(mcmcrs(mcmcr_example, mcmcr_example), normalized = FALSE, folded = FALSE), list(mcmcr1 = 2.002, mcmcr2 = 2.002))
  expect_identical(rhat(mcmcrs(mcmcr_example, mcmcr_example), bound = TRUE, normalized = FALSE, folded = FALSE), 0.999)
  expect_identical(rhat(mcmcrs(mcmcr_example, mcmcr_example), by = "parameter", normalized = FALSE, folded = FALSE),
                   list(mcmcr1 = list(alpha = 2.002, beta = 1.147, sigma = 0.998),
                        mcmcr2 = list(alpha = 2.002, beta = 1.147, sigma = 0.998)))
  expect_identical(rhat(mcmcrs(mcmcr_example, mcmcr_example), bound = TRUE, by = "parameter", normalized = FALSE, folded = FALSE),
                   list(alpha = 0.999, beta = 0.999, sigma = 0.999))
})
