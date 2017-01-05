context("subset")

test_that("subset.mcmcarray", {
  mcmcarray <- mcmcr[[2]]

  expect_identical(nchains(subset(mcmcarray, 1L)), 1L)
  expect_identical(nchains(subset(mcmcarray, rep(1L, 5))), 5L)
  expect_identical(nsamples(subset(mcmcarray, rep(1L, 5), 2:3)), 10L)
})

test_that("subset.mcmcr", {
  expect_identical(nchains(subset(mcmcr, 1L)), 1L)
  expect_identical(nsamples(subset(mcmcr, rep(1L, 5), 2:3)), 10L)
  expect_identical(nterms(subset(mcmcr, parameters = c("beta"))), 4L)
})

