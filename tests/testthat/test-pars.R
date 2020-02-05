context("pars")

test_that("pars.mcmcr", {
  expect_equal(pars(mcmcr::mcmcr_example), c("alpha", "beta", "sigma"))
  rlang::with_options(lifecycle_verbosity = "quiet", {
  expect_equal(pars(mcmcr::mcmcr_example, scalar = TRUE), c("sigma"))
  expect_error(pars(mcmcr::mcmcr_example, scalar = FALSE))
  })
  pars(mcmcr_example) <- c("alpha1", "alpha2", "alpha3")
  expect_equal(pars(mcmcr_example), c("alpha1", "alpha2", "alpha3"))
})

test_that("pars.mcmcrs", {
  mcmcrs <- mcmcrs(mcmcr::mcmcr_example, mcmcr::mcmcr_example)
  expect_equal(pars(mcmcrs), c("alpha", "beta", "sigma"))
  rlang::scoped_options(lifecycle_verbosity = "quiet")

  expect_equal(pars(mcmcrs, scalar = TRUE), c("sigma"))
  expect_error(pars(mcmcrs, scalar = FALSE))
  pars(mcmcrs) <- c("alpha1", "alpha2", "alpha3")
  expect_equal(pars(mcmcrs), c("alpha1", "alpha2", "alpha3"))
})
