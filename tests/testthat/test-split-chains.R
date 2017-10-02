context("split_chains")

test_that("split_chains.mcmcarray", {
  x <- split_chains(mcmcr[[2]])
  expect_is(x, "mcmcarray")
  expect_identical(nchains(x), 4L)
  expect_identical(niters(x) * nchains(x), niters(mcmcr[[2]]) * nchains(mcmcr[[2]]))
})

test_that("collapse_chains.mcmcr", {
  x <- split_chains(mcmcr)
  expect_is(x, "mcmcr")
  expect_identical(nchains(x), 4L)
  expect_identical(niters(x) * nchains(x), niters(mcmcr) * nchains(mcmcr))
})
