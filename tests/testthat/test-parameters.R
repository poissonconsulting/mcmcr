test_that("parameters.mcmcr", {
  expect_identical(parameters(mcmcr::mcmcr_example), c("alpha", "beta", "sigma"))
  expect_identical(parameters(mcmcr::mcmcr_example, scalar = TRUE), c("sigma"))
  expect_identical(parameters(mcmcr::mcmcr_example, scalar = FALSE), c("alpha", "beta"))
  parameters(mcmcr_example) <- c("alpha1", "alpha2", "alpha3")
  expect_identical(parameters(mcmcr_example), c("alpha1", "alpha2", "alpha3"))
})

test_that("parameters.mcmcrs", {
  mcmcrs <- mcmcrs(mcmcr::mcmcr_example, mcmcr::mcmcr_example)
  expect_identical(parameters(mcmcrs), c("alpha", "beta", "sigma"))
  expect_identical(parameters(mcmcrs, scalar = TRUE), c("sigma"))
  expect_identical(parameters(mcmcrs, scalar = FALSE), c("alpha", "beta"))
  parameters(mcmcrs) <- c("alpha1", "alpha2", "alpha3")
  expect_identical(parameters(mcmcrs), c("alpha1", "alpha2", "alpha3"))
})
