context("rhat")

test_that("rhat.matrix", {
  matrix <- matrix(1, nrow = 2, ncol = 100)
  expect_identical(rhat(matrix), 1)
  matrix[1,] <- 2
  expect_true(is.infinite(rhat(matrix)))
    matrix[1,1] <- NA
  expect_true(is.na(rhat(matrix)))
})
#
# test_that("rhat.mcmcmarray", {
#   expect_identical(rhat(mcmcr_example[[1]], by = "term"), c(1, 1))
#
#   expect_equivalent(rhat(mcmcr_example[[2]], by = "term"), matrix(c(1, 1, 1, 1), nrow = 2, ncol = 2))
#   expect_identical(rhat(mcmcr_example[[3]], by = "term"), c(1))
#   expect_identical(rhat(mcmcr_example[[2]]), c(1))
#   expect_identical(rhat(mcmcr_example[[1]], "parameter"), rhat(mcmcr_example[[1]], "all"))
# })
#
# test_that("rhat.mcmcr", {
#   expect_identical(rhat(mcmcr_example), 1)
#   expect_identical(rhat(mcmcr_example, by = "parameter"), list(alpha = 1, beta = 1, sigma = 1))
#   expect_equivalent(rhat(mcmcr_example, by = "term"), list(alpha = c(1, 1), beta = matrix(c(1, 1, 1, 1), nrow = 2, ncol = 2), sigma = 1))
# })
#
# test_that("rhat.mcmcrs", {
#   expect_identical(rhat(mcmcrs(mcmcr_example)), list(mcmcr1 = 1))
# })
