context("npdims")

test_that("npdims", {
  expect_identical(npdims(mcmcr_example2), c(alpha = 3L, beta = 3L, sigma = 3L))
  expect_identical(npdims(mcmcr_example), c(alpha = 1L, beta = 2L, sigma = 1L))
})
