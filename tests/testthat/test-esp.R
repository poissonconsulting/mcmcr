context("esp")

test_that("esp.mcmcmarray", {
  expect_identical(esp(mcmcr[[1]], by = "term"), c(0.82, 0.82))
  expect_equivalent(esp(mcmcr[[2]], by = "term"), matrix(c(0, 0, 0, 0), nrow = 2, ncol = 2))
  expect_identical(esp(mcmcr[[3]], by = "term"), c(0.37))
  expect_identical(esp(mcmcr[[2]]), 0)
  expect_identical(esp(mcmcr[[1]], "parameter"), esp(mcmcr[[1]], "all"))
})

test_that("rhat.mcmcr", {
  expect_identical(esp(mcmcr), 0)
  expect_identical(esp(mcmcr, by = "parameter"), list(alpha = 0.82, beta = 0, sigma = 0.37))
  expect_equivalent(esp(mcmcr, by = "term"), list(alpha = c(0.82, 0.82), beta = matrix(c(0, 0, 0, 0), nrow = 2, ncol = 2), sigma = 0.37))
})

