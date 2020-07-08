test_that("pars.mcmcr", {
  expect_identical(pars(mcmcr::mcmcr_example), c("alpha", "beta", "sigma"))
  expect_identical(pars(mcmcr::mcmcr_example, scalar = TRUE), c("sigma"))
  expect_identical(pars(mcmcr::mcmcr_example, scalar = FALSE), c("alpha", "beta"))
  pars(mcmcr_example) <- c("alpha1", "alpha2", "alpha3")
  expect_identical(pars(mcmcr_example), c("alpha1", "alpha2", "alpha3"))
})

test_that("pars.mcmcrs", {
  mcmcrs <- mcmcrs(mcmcr::mcmcr_example, mcmcr::mcmcr_example)
  expect_identical(pars(mcmcrs), c("alpha", "beta", "sigma"))
  expect_identical(pars(mcmcrs, scalar = TRUE), c("sigma"))
  expect_identical(pars(mcmcrs, scalar = FALSE), c("alpha", "beta"))
  pars(mcmcrs) <- c("alpha1", "alpha2", "alpha3")
  expect_identical(pars(mcmcrs), c("alpha1", "alpha2", "alpha3"))
})
