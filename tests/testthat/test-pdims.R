context("pdims")

test_that("pdims", {
  expect_identical(pdims(mcmcr_example2), list(alpha = c(2L, 1L, 1L), beta = c(2L,2L,2L), sigma = c(1L,1L,1L)))
  expect_identical(pdims(mcmcr_example), list(alpha = 2L, beta = c(2L,2L), sigma = 1L))
})
