context("ess")

test_that("ess.mcmcmarray", {
  expect_identical(ess(mcmcr::mcmcr_example[[1]], by = "term"), c(400L, 400L))
  expect_equivalent(ess(mcmcr::mcmcr_example[[2]], by = "term"), matrix(c(324L, 324L, 324L, 324L), nrow = 2))
  expect_identical(ess(mcmcr::mcmcr_example[[3]], by = "term"), c(184L))
  expect_identical(ess(mcmcr::mcmcr_example[[2]]), 324L)
  expect_identical(ess(mcmcr::mcmcr_example[[1]], "parameter"), ess(mcmcr::mcmcr_example[[1]], "all"))
})

test_that("ess.mcmcr", {
  expect_identical(ess(mcmcr::mcmcr_example), 184L)
  expect_identical(ess(mcmcr::mcmcr_example, by = "parameter"), list(alpha = 400L, beta = 324L, sigma = 184L))
})

test_that("ess.mcmcrs", {
  expect_identical(ess(mcmcrs(mcmcr::mcmcr_example), by = "parameter")[[1]], list(alpha = 400L, beta = 324L, sigma = 184L))
})
