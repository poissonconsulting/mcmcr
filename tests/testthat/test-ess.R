context("ess")

test_that("ess.mcmcmarray", {
  expect_identical(ess(mcmcr[[1]], by = "term"), c(1640L, 1640L))
  expect_equivalent(ess(mcmcr[[2]], by = "term"), matrix(c(0L, 0L, 0L, 0L), nrow = 2, ncol = 2))
  expect_identical(ess(mcmcr[[3]], by = "term"), c(760L))
  expect_identical(ess(mcmcr[[2]]), 0L)
  expect_identical(ess(mcmcr[[1]], "parameter"), ess(mcmcr[[1]], "all"))
})

test_that("ess.mcmcr", {
  expect_identical(ess(mcmcr), 0L)
  expect_identical(ess(mcmcr, by = "parameter"), list(alpha = 1640L, beta = 0L, sigma = 760L))
})

test_that("ess.mcmcrs", {
  expect_identical(ess(mcmcrs_example, by = "parameter")[[1]], list(alpha = 1640L, beta = 0L, sigma = 760L))
})


