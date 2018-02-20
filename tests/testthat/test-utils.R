context("utils")

test_that("n", {
  expect_identical(nterms(mcmcr_example), 7L)
  expect_identical(nsims(mcmcr_example), 400L)
  expect_identical(nsams(mcmcr_example), 2800L)
})
