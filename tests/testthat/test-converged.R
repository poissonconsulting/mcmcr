context("converged")

test_that("converged.mcmcr", {
  expect_false(converged(mcmcr_example))
  expect_false(converged(mcmcr_example2))
})

test_that("converged.mcmcarray", {
  expect_true(converged(mcmcr_example$sigma))
})
