test_that("subset.mcmcr", {
  expect_identical(
    pars(subset(mcmcr_example, pars = rev(pars(mcmcr_example)))),
    rev(pars(mcmcr_example))
  )
  expect_identical(nchains(subset(mcmcr_example, 1L)), 1L)
  expect_identical(nsims(subset(mcmcr_example, rep(1L, 5), 2:3)), 10L)
  expect_identical(nterms(subset(mcmcr_example, pars = "beta")), 4L)
})

test_that("subset.mcmcrs", {
  mcmcrs <- mcmcrs(mcmcr::mcmcr_example, mcmcr::mcmcr_example)
  expect_identical(
    pars(subset(mcmcrs, pars = rev(pars(mcmcrs)))),
    rev(pars(mcmcrs))
  )
  expect_identical(nchains(subset(mcmcrs, 1L)), 1L)
  expect_identical(nsims(subset(mcmcrs, rep(1L, 5), 2:3)), 10L)
  expect_identical(nterms(subset(mcmcrs, pars = "beta")), 4L)
})

test_that("subset iterations and parameters arguments are deprecated", {
  lifecycle::expect_deprecated(subset(mcmcr_example$beta, iterations = 1:10))
  lifecycle::expect_deprecated(subset(mcmcr_example, iterations = 1:10))
  lifecycle::expect_deprecated(subset(mcmcr_example, parameters = "beta"))
  mcmcrs <- mcmcrs(mcmcr::mcmcr_example, mcmcr::mcmcr_example)
  lifecycle::expect_deprecated(subset(mcmcrs, iterations = 1:10))
  lifecycle::expect_deprecated(subset(mcmcrs, parameters = "beta"))

  rlang::local_options(lifecycle_verbosity = "quiet")
  expect_identical(
    subset(mcmcr_example, iterations = 1:10, parameters = "beta"),
    subset(mcmcr_example, iters = 1:10, pars = "beta")
  )
})

test_that("subset.mcmc.list", {
  expect_identical(
    pars(subset(as.mcmc.list(mcmcr_example), pars = "beta")),
    "beta"
  )
  expect_identical(niters(subset(as.mcmc.list(mcmcr_example), iters = 10L)), 1L)
  expect_identical(
    nchains(subset(as.mcmc.list(mcmcr_example), chains = 2L)),
    1L
  )
})
