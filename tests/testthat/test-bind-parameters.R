context("bind_parameters")

test_that("bind_parameters", {

  x <- mcmcr
  x2 <- mcmcr

  expect_error(bind_parameters(x, x2), "x and x2 must not have the same parameters")

  parameters(x) <- paste0(parameters(x), "1")

  x <- bind_parameters(x, x2)

  expect_identical(names(x), c("alpha1", "beta1", "sigma1",
                               "alpha", "beta", "sigma"))
  expect_identical(niters(x), niters(mcmcr))
  expect_identical(nchains(x), nchains(mcmcr))
})

test_that("bind_parameters.mcmcrs", {
  x <- bind_parameters(as.mcmcrs(list(mcmcr, mcmcr)))

  expect_is(x, "mcmcr")
  expect_identical(names(x), c("alpha1", "beta1", "sigma1",
                               "alpha2", "beta2", "sigma2"))
  expect_identical(niters(x), niters(mcmcr))
  expect_identical(nchains(x), nchains(mcmcr))
})
