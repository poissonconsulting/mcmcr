context("converged")

test_that("converged", {
  expect_true(converged(mcmcr_example))
  expect_true(converged(mcmcr_example2))
  expect_true(converged(bind_dimensions(mcmcr_example, mcmcr_example)))
})
