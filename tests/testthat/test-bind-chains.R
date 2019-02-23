context("bind_chains")

test_that("bind_chains", {
  expect_identical(nchains(bind_chains(as.mcarray(mcmcr_example$beta), as.mcarray(mcmcr_example$beta))), 4L)
  expect_identical(nchains(bind_chains(as.mcmc.list(mcmcr_example), as.mcmc.list(mcmcr_example))), 4L)
  expect_identical(nchains(bind_chains(mcmcr_example$beta, mcmcr_example$beta)), 4L)
  expect_identical(nchains(bind_chains(mcmcr_example, mcmcr_example)), 4L)
  expect_identical(nchains(bind_chains(mcmcr_example2, mcmcr_example2)), 4L)
})
