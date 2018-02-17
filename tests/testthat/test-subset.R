context("subset")

test_that("subset.mcmcarray", {
  mcmcarray <- mcmcr[[2]]
  expect_identical(nchains(subset(mcmcarray, 1L)), 1L)
  expect_identical(nchains(subset(mcmcarray, rep(1L, 5))), 5L)
  expect_identical(nsims(subset(mcmcarray, rep(1L, 5), 2:3)), 10L)
})

test_that("subset.mcmcr", {
  expect_identical(parameters(subset(mcmcr, parameters = rev(parameters(mcmcr)))), rev(parameters(mcmcr)))
  expect_identical(nchains(subset(mcmcr, 1L)), 1L)
  expect_identical(nsims(subset(mcmcr, rep(1L, 5), 2:3)), 10L)
  expect_identical(nterms(subset(mcmcr, parameters = c("beta"))), 4L)
})

test_that("subset.mcmc", {

  data("line", package = "coda", envir = environment())
  mcmc <- line[[1]]

  expect_identical(parameters(subset(mcmc, parameters = "beta")), "beta")
  expect_identical(niters(subset(mcmc, iterations = 10L)), 1L)
})

test_that("subset.mcmc.list", {

  data("line", package = "coda", envir = environment())

  expect_identical(parameters(subset(line, parameters = "beta")), "beta")
  expect_identical(niters(subset(mcmc, iterations = 10L)), 1L)
  expect_identical(nchains(subset(mcmc, chains = 2L)), 1L)
})
