test_that("zero.mcarray", {
  rlang::scoped_options(lifecycle_verbosity = "quiet")

  mcarray <- as.mcarray(mcmcr_example[[2]])
  expect_equal(estimates(zero(mcarray)), matrix(0, nrow = 2, ncol = 2), ignore_attr = FALSE)
})


test_that("zero.mcmcarray", {
  rlang::scoped_options(lifecycle_verbosity = "quiet")

  mcmcarray <- mcmcr_example[[2]]
  expect_equal(estimates(zero(mcmcarray)), matrix(0, nrow = 2, ncol = 2), ignore_attr = FALSE)
})

test_that("zero.mcmcr", {
  rlang::scoped_options(lifecycle_verbosity = "quiet")

  mcmcr0 <- zero(mcmcr_example, pars = "sigma")
  expect_identical(estimates(mcmcr0)$sigma, 0)
  expect_identical(estimates(mcmcr0)$beta, estimates(mcmcr_example)$beta)
})

test_that("zero.mcmcr pars = NULL", {
  rlang::scoped_options(lifecycle_verbosity = "quiet")

  mcmcr0 <- zero(mcmcr_example)
  expect_identical(estimates(mcmcr0)$sigma, 0)
  expect_identical(estimates(mcmcr0)$beta, matrix(0, 2, 2))
})

test_that("zero.mcmcr2", {
  rlang::scoped_options(lifecycle_verbosity = "quiet")

  mcmcr0 <- zero(mcmcr_example2, pars = "beta")
  expect_true(all(estimates(mcmcr0)$beta == 0))
  expect_identical(pdims(mcmcr0), pdims(mcmcr_example2))
  expect_identical(estimates(mcmcr0)$sigma, estimates(mcmcr_example2)$sigma)
})
