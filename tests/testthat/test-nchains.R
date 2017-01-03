context("nchains")

test_that("nchains", {
  expect_identical(nchains(list_mcarrays[[1]]), 2L)
  expect_identical(nchains(mcmcr), 2L)
  expect_identical(nchains(mcmcr[[1]]), 2L)
})
