context("pdims")

test_that("pdims", {
  expect_identical(pdims(mcmcr_example), list(alpha = 2L, beta = c(2L,2L), sigma = 1L))
})
