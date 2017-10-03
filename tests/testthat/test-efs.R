context("efs")

test_that("efs.mcmcmarray", {
  expect_identical(efs(mcmcr[[1]], by = "term"), c(0.82, 0.82))
  expect_equivalent(efs(mcmcr[[2]], by = "term"), matrix(c(0, 0, 0, 0), nrow = 2, ncol = 2))
  expect_identical(efs(mcmcr[[3]], by = "term"), c(0.37))
  expect_identical(efs(mcmcr[[2]]), 0)
  expect_identical(efs(mcmcr[[1]], "parameter"), efs(mcmcr[[1]], "all"))
})

test_that("rhat.mcmcr", {
  expect_identical(efs(mcmcr), 0)
  expect_identical(efs(mcmcr, by = "parameter"), list(alpha = 0.82, beta = 0, sigma = 0.37))
  expect_equivalent(efs(mcmcr, by = "term"), list(alpha = c(0.82, 0.82), beta = matrix(c(0, 0, 0, 0), nrow = 2, ncol = 2), sigma = 0.37))
})

