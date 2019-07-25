context("subset")

test_that("subset.mcmcr", {
  expect_identical(pars(subset(mcmcr_example, parameters = rev(pars(mcmcr_example)))), rev(parameters(mcmcr_example)))
  expect_identical(nchains(subset(mcmcr_example, 1L)), 1L)
  expect_identical(nsims(subset(mcmcr_example, rep(1L, 5), 2:3)), 10L)
  expect_identical(nterms(subset(mcmcr_example, parameters = "beta")), 4L)
})

test_that("subset.mcmcrs", {
  mcmcrs <- mcmcrs(mcmcr::mcmcr_example, mcmcr::mcmcr_example)
  expect_identical(pars(subset(mcmcrs, parameters = rev(pars(mcmcrs)))), rev(parameters(mcmcrs)))
  expect_identical(nchains(subset(mcmcrs, 1L)), 1L)
  expect_identical(nsims(subset(mcmcrs, rep(1L, 5), 2:3)), 10L)
  expect_identical(nterms(subset(mcmcrs, parameters = "beta")), 4L)
})

test_that("subset.mcmc.list", {
  expect_identical(pars(subset(as.mcmc.list(mcmcr_example), parameters = "beta")), "beta")
  expect_identical(niters(subset(as.mcmc.list(mcmcr_example), iterations = 10L)), 1L)
  expect_identical(nchains(subset(as.mcmc.list(mcmcr_example), chains = 2L)), 1L)
})
