context("as-mcmcr")

test_that("as.mcmcr.list", {
  expect_identical(as.mcmcr(unclass(mcmcr::mcmcr_example)), mcmcr::mcmcr_example)
})

test_that("as.mcmcr.mcarray", {
  mcmcr <- subset(mcmcr::mcmcr_example, pars = "beta")
  expect_identical(as.mcmcr(as.mcarray(mcmcr), "beta"), mcmcr)
})

test_that("as.mcmcr.mcmcarray", {
  mcmcr <- subset(mcmcr::mcmcr_example, pars = "beta")
  expect_identical(as.mcmcr(as.mcmcarray(mcmcr), "beta"), mcmcr)
})

test_that("as.mcmcr.nlist", {
  mcmcr <- subset(mcmcr::mcmcr_example, chains = 1L, iters = 1L)
  expect_identical(as.mcmcr(nlist::as_nlist(mcmcr)), mcmcr)
})

test_that("as.mcmcr.nlists", {
  mcmcr <- subset(mcmcr::mcmcr_example, chains = 1L)
  expect_identical(as.mcmcr(nlist::as_nlists(mcmcr)), mcmcr)
})

test_that("as.mcmcr.mcmc", {
  mcmcr <- subset(mcmcr::mcmcr_example, chains = 1L)
  expect_identical(as.mcmcr(coda::as.mcmc(mcmcr)), mcmcr)
})

test_that("as.mcmcr.mcmc.list", {
  expect_identical(as.mcmcr(coda::as.mcmc.list(mcmcr::mcmcr_example)),
                   mcmcr::mcmcr_example)
})

test_that("as.mcmcr.mcmcr", {
  expect_identical(as.mcmcr(mcmcr::mcmcr_example), mcmcr::mcmcr_example)
})

test_that("as.mcmcr.mcmcrs", {
  expect_identical(as.mcmcr(as.mcmcrs(mcmcr::mcmcr_example)), mcmcr::mcmcr_example)
})
