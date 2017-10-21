context("mcmc-map")

test_that("mcmc_map", {

  expect_identical(mcmc_map(mcmcr[[1]], identity), mcmcr[[1]])
  expect_identical(mcmc_map(mcmcr[[1]], function(x) x * 10), mcmcr[[1]] * 10)
  expect_error(mcmc_map(mcmcr[[1]], function(x) c(x,x)))
  expect_identical(sum(mcmc_map(mcmcr[[1]], magrittr::multiply_by, 2)), sum(mcmcr[[1]]) * 2)

  expect_is(mcmc_map(mcmcr, function(x) x * 5), "mcmcr")
  expect_identical(mcmc_map(mcmcr, function(x) x * 5)[[2]], mcmcr[[2]] * 5)
})
