test_that("n", {
  expect_identical(nterms(mcmcr_example), 7L)
  expect_identical(nsims(mcmcr_example), 800L)
  expect_identical(nsams(mcmcr_example), 5600L)
})
