test_that("as.mcmc.list", {
  expect_is(coda::as.mcmc.list(as.mcmc(collapse_chains(mcmcr_example))),
            "mcmc.list")

  mcmc.list <- coda::as.mcmc.list(mcmcr_example)
  expect_is(mcmc.list, "mcmc.list")

  expect_identical(coda::nchain(mcmc.list), 2L)
  expect_identical(coda::nvar(mcmc.list), 7L)
  expect_identical(coda::as.mcmc.list(mcmc.list), mcmc.list)
  expect_equal(as.mcmcr(mcmc.list), mcmcr_example, check.attributes = FALSE)
})
