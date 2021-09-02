test_that("combine_samples.mcmcarray", {
  x <- combine_samples(mcmcr_example$beta, mcmcr_example$beta)
  expect_identical(x, mcmcr_example$beta)
  x <- combine_samples(mcmcr_example$beta, mcmcr_example$beta, sum)
  expect_equal(x[1, , , ], mcmcr_example$beta[1, , , ] * 2)
})

test_that("combine_samples.mcmr", {
  x <- combine_samples(mcmcr_example, mcmcr_example)
  expect_identical(x, mcmcr_example)
  x <- combine_samples(mcmcr_example, mcmcr_example, sum)
  expect_equal(x$alpha[1, , ], mcmcr_example$alpha[1, , ] * 2)
})

test_that("combine_samples.mcmr", {
  x <- combine_samples(mcmcr_example2, mcmcr_example2)
  expect_equal(x, mcmcr_example2, ignore_attr = FALSE)
  x <- combine_samples(mcmcr_example2, mcmcr_example2, sum)
  expect_equal(x$alpha[1, 1, 1, , ], mcmcr_example2$alpha[1, 1, 1, , ] * 2)
})
