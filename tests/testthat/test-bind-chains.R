context("bind_chains")

test_that("bind_chains", {
  expect_identical(nchains(bind_chains(as.mcmc.list(mcmcr_example), as.mcmc.list(mcmcr_example))), 4L)
  expect_identical(nchains(bind_chains(mcmcr_example$beta, mcmcr_example$beta)), 4L)
  expect_identical(nchains(bind_chains(mcmcr_example, mcmcr_example)), 4L)
  expect_identical(nchains(bind_chains(mcmcr_example2, mcmcr_example2)), 4L)
})

test_that("bind_chains.mcarray", {
  expect_identical(nchains(bind_chains(as.mcarray(mcmcr_example$beta),
                                       as.mcarray(mcmcr_example$beta))), 4L)

  expect_error(bind_chains(as.mcarray(mcmcr_example$beta), mcmcr_example),
               "x2 must be an mcarray")

  expect_error(bind_chains(as.mcarray(mcmcr_example$beta),
                           as.mcarray(mcmcr_example$alpha)),
               "x and x2 must have the same parameter dimensions")
})

test_that("bind_chains.mcmc", {
  expect_identical(nchains(bind_chains(as.mcmc(collapse_chains(mcmcr_example)),
                                       as.mcmc(collapse_chains(mcmcr_example)))), 2L)

  expect_error(nchains(bind_chains(as.mcmc(collapse_chains(mcmcr_example)),
                                       mcmcr_example)), "x2 must be an mcmc")

  expect_error(bind_chains(as.mcmc(collapse_chains(mcmcr_example$beta)),
                                       as.mcmc(collapse_chains(mcmcr_example))),
               "x and x2 must have the same parameters")


  expect_error(bind_chains(as.mcmc(collapse_chains(thin(mcmcr_example, 2L))),
                                       as.mcmc(collapse_chains(mcmcr_example))),
                   "x and x2 must have the same number of iterations")
})


