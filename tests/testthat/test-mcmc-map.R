context("mcmc-map")

test_that("mcmc_map", {
  expect_identical(mcmc_map(mcmcr_example[[1]], identity), mcmcr_example[[1]])
  expect_identical(mcmc_map(mcmcr_example[[1]], function(x) x * 10), mcmcr_example[[1]] * 10)
  expect_identical(mcmc_map(coda::as.mcmc.list(mcmcr_example[[1]]), function(x) x * 10), coda::as.mcmc.list(mcmcr_example[[1]] * 10))
  expect_error(mcmc_map(mcmcr_example[[1]], function(x) c(x,x)))
  expect_identical(sum(mcmc_map(mcmcr_example[[1]], function(x) (x * 2))), sum(mcmcr_example[[1]]) * 2)
  expect_is(mcmc_map(mcmcr_example, function(x) x * 5), "mcmcr")
  expect_identical(mcmc_map(mcmcr_example, function(x) x * 5)[[2]], mcmcr_example[[2]] * 5)
})
