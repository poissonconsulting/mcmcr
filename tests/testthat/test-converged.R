context("converged")

test_that("converged", {
  expect_false(converged(mcmcr_example))
  expect_false(converged(mcmcr_example2))
  expect_true(converged(mcmcr_example$sigma))
})
