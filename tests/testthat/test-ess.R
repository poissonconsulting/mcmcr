context("ess")

test_that("ess.mcmcmarray", {
  expect_identical(ess(mcmcr_example[[1]], by = "term"), c(8L, 8L))
  expect_equivalent(ess(mcmcr_example[[2]], by = "term"), matrix(c(40L, 40L, 40L, 40L), nrow = 2))
  expect_identical(ess(mcmcr_example[[3]], by = "term"), c(376L))
  expect_identical(ess(mcmcr_example[[2]]), 40L)
  expect_identical(ess(mcmcr_example[[1]], "parameter"), ess(mcmcr_example[[1]], "all"))
})

test_that("ess.mcmcr", {
  expect_identical(ess(mcmcr_example2), 8L)
  expect_identical(ess(mcmcr_example), 8L)
  expect_identical(ess(mcmcr_example, by = "parameter"), list(alpha = 8L, beta = 40L, sigma = 376L))
})

test_that("ess.mcmcrs", {
  expect_identical(ess(mcmcrs(mcmcr_example), by = "parameter")[[1]], list(alpha = 8L, beta = 40L, sigma = 376L))
})

