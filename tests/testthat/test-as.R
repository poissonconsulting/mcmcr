context("as")

test_that("as.mcarray", {
  mcarrays <- lapply(mcmcr::mcmcr_example, as.mcarray)
  mcmcarrays <- lapply(mcarrays, as.mcmcarray)
  expect_equal(mcmcarrays, unclass(mcmcr::mcmcr_example), check.attributes = FALSE)
  mcarrays2 <- lapply(mcmcarrays, as.mcarray)
  expect_equal(mcarrays2, mcarrays)
})

test_that("as.mcmcrs", {
  expect_is(as.mcmcrs(list(mcmcr::mcmcr_example, mcmcr::mcmcr_example)), "mcmcrs")
})

test_that("as.mcmc.list", {
  mcmc.list <- coda::as.mcmc.list(mcmcr::mcmcr_example)
  expect_is(mcmc.list, "mcmc.list")

  expect_identical(coda::nchain(mcmc.list), 2L)
  expect_identical(coda::nvar(mcmc.list), 7L)
  expect_equal(as.mcmcr(mcmc.list), mcmcr::mcmcr_example)
})

test_that("as.mcmcr.mcmc", {
  mcmc <- as.mcmc.list(mcmcr)[[2]]
  as.mcmcr(mcmc)
  expect_identical(as.mcmcr(mcmc_list), mcmcr)
})

test_that("as.mcmcr.mcmc.list", {
  mcmc_list <- as.mcmc.list(mcmcr)
  expect_identical(as.mcmcr(mcmc_list), mcmcr)
})
