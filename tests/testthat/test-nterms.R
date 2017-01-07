context("nterms")

test_that("nterms.mcmcmarray", {
  expect_identical(nterms(mcmcr[[1]]), 2L)
  expect_identical(nterms(mcmcr[[2]]), 4L)
  expect_identical(nterms(mcmcr[[3]]), 1L)
})

test_that("rhat.mcmcr", {
  expect_identical(nterms(mcmcr), 7L)
})
