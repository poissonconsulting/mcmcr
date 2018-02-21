context("bind_iterations")

test_that("bind_iterations", {
  expect_identical(niters(bind_iterations(as.mcarray(mcmcr_example$beta), as.mcarray(mcmcr_example$beta))), 400L)
  expect_identical(niters(bind_iterations(coda::as.mcmc.list(mcmcr_example), coda::as.mcmc.list(mcmcr_example))), 400L)
  expect_identical(niters(bind_iterations(mcmcr_example$beta, mcmcr_example$beta)), 400L)
  expect_identical(niters(bind_iterations(mcmcr_example, mcmcr_example)), 400L)
  expect_identical(niters(bind_iterations(mcmcr_example2, mcmcr_example2)), 400L)
})
