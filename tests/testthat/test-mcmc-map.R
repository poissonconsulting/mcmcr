context("mcmc-map")

test_that("mcmc_map", {
  expect_identical(mcmc_map(mcmcr_example[[1]], identity), mcmcr_example[[1]])
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

test_that("mcmc_map with arrays identical", {
  x <- array(1:prod(2:7), dim = 2:7)
  class(x) <- "mcmcarray"
  expect_identical(mcmc_map(x, .f = identity), x)
  expect_identical(mcmc_map(x, .f = identity, .by = TRUE), x)
  expect_identical(mcmc_map(x, .f = identity, .by = FALSE), x)
  expect_identical(mcmc_map(x, .f = identity, .by = 1L), x)
  expect_identical(mcmc_map(x, .f = identity, .by = 2L), x)
  expect_identical(mcmc_map(x, .f = identity, .by = c(2L, 4L)), x)
})

test_that("mcmc_map with arrays rescale", {
  x <- array(1:prod(2:7), dim = 2:7)
  class(x) <- "mcmcarray"
  expect_identical(estimates(mcmc_map(x, .f = function(x) x / sum(x))), array(1, dim = 4:7))
  expect_identical(sum(estimates(mcmc_map(x, .f = function(x) x / sum(x)))), 840)
  expect_identical(sum(estimates(mcmc_map(x, .f = function(x) x / sum(x), .by = FALSE))), 1)
  expect_identical(sum(estimates(mcmc_map(x, .f = function(x) x / sum(x), .by = c(2L, 4L)))), 35)
})
