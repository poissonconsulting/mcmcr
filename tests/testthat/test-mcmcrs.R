context("mcmcrs")

test_that("mcmcrs", {
  expect_is(mcmcrs(), "mcmcrs")
  mcmcrs <- mcmcrs(mcmcr, mcmcr)
  expect_is(mcmcrs, "mcmcrs")
  expect_true(is.mcmcrs(mcmcrs))
  expect_identical(length(mcmcrs), 2L)

  expect_identical(rhat(mcmcrs), 1)
  expect_true(converged(mcmcrs))

  mcmcr2 <- mcmcr
  mcmcr2[[1]] <- mcmcr2[[1]] + 1
  mcmcrs <- mcmcrs(mcmcr, mcmcr2)
  expect_identical(rhat(mcmcrs), 2.53)
  expect_false(converged(mcmcrs))
})
