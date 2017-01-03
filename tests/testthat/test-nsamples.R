context("nsamples")

test_that("nsamples", {
  expect_identical(nsamples(list_mcarrays[[1]]), 2000L)
  expect_identical(nsamples(mcmcr), 2000L)
  expect_identical(nsamples(mcmcr[[1]]), 2000L)
})
