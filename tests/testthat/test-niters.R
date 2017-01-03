context("niters")

test_that("niters", {
  expect_identical(niters(list_mcarrays[[1]]), 1000L)
  expect_identical(niters(mcmcr), 1000L)
  expect_identical(niters(mcmcr[[1]]), 1000L)
})
