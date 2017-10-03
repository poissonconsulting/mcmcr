context("mcmcrs")

test_that("mcmcrs", {
  expect_is(mcmcrs(), "mcmcrs")
  mcmcrs <- mcmcrs(mcmcr, mcmcr)
  expect_is(mcmcrs, "mcmcrs")
  expect_true(is.mcmcrs(mcmcrs))
  expect_identical(length(mcmcrs), 2L)

  expect_identical(rhat(mcmcrs), 1.77)
  expect_false(converged(mcmcrs))

  mcmcr2 <- mcmcr
  mcmcr2[[1]] <- mcmcr2[[1]] + 1
  mcmcrs <- mcmcrs(mcmcr, mcmcr2)
  expect_identical(rhat(mcmcrs), 1.77)
  expect_false(converged(mcmcrs))
})

test_that("add_mcmcrs", {

  mcmcrs <- add_mcmcrs(mcmcr, mcmcr)
  expect_is(mcmcrs(), "mcmcrs")
  expect_identical(length(mcmcrs), 2L)

  mcmcrs <- add_mcmcrs(mcmcrs, mcmcr)
  expect_is(mcmcrs(), "mcmcrs")
  expect_identical(length(mcmcrs), 3L)

  mcmcrs <- add_mcmcrs(mcmcr, mcmcrs)
  expect_is(mcmcrs(), "mcmcrs")
  expect_identical(length(mcmcrs), 4L)

  mcmcrs <- add_mcmcrs(mcmcrs, mcmcrs)
  expect_is(mcmcrs(), "mcmcrs")
  expect_identical(length(mcmcrs), 8L)
})

