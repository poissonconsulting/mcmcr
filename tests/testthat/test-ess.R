context("ess")

test_that("ess.mcmcmarray", {
  expect_identical(ess(mcmcr[[1]], by = "term"), c(1648L, 1648L))
  expect_equivalent(ess(mcmcr[[2]], by = "term"), matrix(c(9L, 9L, 9L, 9L), nrow = 2, ncol = 2))
  expect_identical(ess(mcmcr[[3]], by = "term"), c(749L))
  expect_identical(ess(mcmcr[[2]]), 9L)
  expect_identical(ess(mcmcr[[1]], "parameter"), ess(mcmcr[[1]], "all"))
})

test_that("ess.mcmcr", {
  expect_identical(ess(mcmcr), 9L)
  expect_identical(ess(mcmcr, by = "parameter"), list(alpha = 1648L, beta = 9L, sigma = 749L))
})

test_that("ess.mcmcrs", {
  expect_identical(ess(mcmcrs_example, by = "parameter")[[1]], list(alpha = 1648L, beta = 9L, sigma = 749L))
})


