context("mcmc-map")

test_that("mcmc_map", {
  expect_identical(mcmc_map(mcmcr::mcmcr_example[[1]], identity), mcmcr::mcmcr_example[[1]])
  expect_identical(mcmc_map(mcmcr::mcmcr_example[[1]], function(x) x * 10), mcmcr::mcmcr_example[[1]] * 10)
  expect_error(mcmc_map(mcmcr::mcmcr_example[[1]], function(x) c(x,x)))
  expect_identical(sum(mcmc_map(mcmcr::mcmcr_example[[1]], function(x) (x * 2))), sum(mcmcr::mcmcr_example[[1]]) * 2)
  expect_is(mcmc_map(mcmcr::mcmcr_example, function(x) x * 5), "mcmcr")
  expect_identical(mcmc_map(mcmcr::mcmcr_example, function(x) x * 5)[[2]], mcmcr::mcmcr_example[[2]] * 5)
})
