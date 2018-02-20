context("combine_samples")

test_that("combine_samples.mcmcarray", {
  x <- combine_samples(mcmcr::mcmcr_example$beta, mcmcr::mcmcr_example$beta)
  expect_identical(x, mcmcr::mcmcr_example$beta)
  x <- combine_samples(mcmcr::mcmcr_example$beta, mcmcr::mcmcr_example$beta, sum)
  expect_equal(x[1,,,], mcmcr::mcmcr_example$beta[1,,,] * 2)
})

test_that("combine_samples.mcmr", {
  x <- combine_samples(mcmcr::mcmcr_example, mcmcr::mcmcr_example)
  expect_identical(x, mcmcr::mcmcr_example)
  x <- combine_samples(mcmcr::mcmcr_example, mcmcr::mcmcr_example, sum)
  expect_equal(x$alpha[1,,,], mcmcr::mcmcr_example$alpha[1,,,] * 2)
})
