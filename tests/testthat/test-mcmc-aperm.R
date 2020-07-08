test_that("mcmc_aperm", {
  expect_identical(mcmc_aperm(mcmcr_example[[1]], perm = 1L), mcmcr_example[[1]])
  expect_identical(mcmc_aperm(mcmcr_example[[1]]), mcmcr_example[[1]])
})

test_that("mcmc_aperm with big one", {
  x <- array(1:prod(2:7), dim = 2:7)
  class(x) <- "mcmcarray"
  expect_identical(mcmc_aperm(x, perm = 1L), x)
  expect_identical(pdims(mcmc_aperm(x)), rev(pdims(x)))
  expect_identical(pdims(mcmc_aperm(x, perm = c(2L, 4L))), c(5L, 7L, 4L, 6L))
})

test_that("mcmc_aperm.mcmc", {
  expect_identical(mcmc_aperm(coda::as.mcmc(collapse_chains(mcmcr_example))),
                   coda::as.mcmc(collapse_chains(mcmcr_example)))
})

test_that("mcmc_aperm.mcmc.list", {
  expect_identical(mcmc_aperm(coda::as.mcmc.list(mcmcr_example)),
                   coda::as.mcmc.list(mcmcr_example))
})

test_that("mcmc_aperm.mcmcr", {
  expect_identical(mcmc_aperm(mcmcr_example), mcmcr_example)
})

test_that("mcmc_aperm.mcmcrs", {
  expect_identical(mcmc_aperm(as.mcmcrs(list(mcmcr_example, mcmcr_example)), perm = 1L), as.mcmcrs(list(mcmcr_example, mcmcr_example)))
})
