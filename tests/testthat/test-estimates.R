context("estimates")

test_that("estimates", {
  expect_equal(estimates(mcmcr[[1]]), c(2.998247, 3.998247))
  expect_equal(estimates(mcmcr[[3]]), c(0.8265352))
  expect_identical(estimates(mcmcr)$alpha, estimates(mcmcr[[1]]))
})
