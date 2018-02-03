context("mcmcrs")

test_that("mcmcrs", {
  expect_is(mcmcrs_example, "mcmcrs")
  expect_true(is.mcmcrs(mcmcrs_example))
  expect_identical(length(mcmcrs_example), 2L)

  expect_identical(rhat(mcmcrs_example), list(mcmcr1 = 1.87, mcmcr2 = 1.87))
  expect_identical(converged(mcmcrs_example), list(mcmcr1 = FALSE, mcmcr2 = FALSE))
})
