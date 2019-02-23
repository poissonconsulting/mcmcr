context("mcmc-map")

test_that("mcmc_map", {
  expect_equal(mcmc_map(mcmcr_example[[1]], identity), mcmcr_example[[1]],
               check.attributes = FALSE)
  expect_identical(mcmc_map(mcmcr_example[[1]], function(x) x * 10), mcmcr_example[[1]] * 10)
  expect_identical(mcmc_map(as.mcmc.list(mcmcr_example[[1]]), function(x) x * 10), as.mcmc.list(mcmcr_example[[1]] * 10))
  expect_error(mcmc_map(mcmcr_example[[1]], function(x) c(x,x)))
  expect_identical(sum(mcmc_map(mcmcr_example[[1]], function(x) (x * 2))), sum(mcmcr_example[[1]]) * 2)
  expect_is(mcmc_map(mcmcr_example, function(x) x * 5), "mcmcr")
  expect_identical(mcmc_map(mcmcr_example, function(x) x * 5)[[2]], mcmcr_example[[2]] * 5)
})

test_that("mcmc_map with vector", {
  expect_identical(mcmc_map(mcmcr_example[[1]], .f = function(x) x / 1, .by = TRUE), mcmcr_example[[1]])
  expect_identical(mcmc_map(mcmcr_example[[1]], .f = function(x) x / 1, .by = FALSE), mcmcr_example[[1]])
  expect_identical(estimates(mcmc_map(mcmcr_example[[1]], .f = function(x) x / sum(x), .by = TRUE)), c(1, 1))
  expect_equal(estimates(mcmc_map(mcmcr_example[[1]], .f = function(x) x / sum(x), .by = FALSE)), c(0.4407305, 0.5592695), tolerance = 1e-07)
})

