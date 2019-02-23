context("pdims")

test_that("pdims", {
  expect_identical(pdims(mcmcr_example2), list(alpha = c(2L, 1L, 1L), beta = c(2L,2L,2L), sigma = c(1L,1L,1L)))
  expect_identical(pdims(mcmcr_example), list(alpha = 2L, beta = c(2L,2L), sigma = 1L))
  expect_identical(pdims(mcmcr_example[[1]]), 2L)
  expect_identical(pdims(mcmcr_example2[[1]]), c(2L, 1L, 1L))
  expect_identical(pdims(as.term(as.mcmc.list(mcmcr_example[[1]])[[1]])), list(2L))
  expect_identical(pdims(as.mcmc.list(mcmcr_example[[1]])[[1]]), list(2L))
  expect_identical(pdims(as.mcmc.list(mcmcr_example[[1]])), list(2L))
})
