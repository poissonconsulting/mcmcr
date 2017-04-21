context("collapse_chains")

test_that("collapse_chains.mcmcarray", {
  x <- collapse_chains(mcmcr[[2]])
  expect_is(x, "mcmcarray")
  expect_identical(nchains(x), 1L)
  expect_identical(niters(x), niters(mcmcr[[2]]) * nchains(mcmcr[[2]]))
})

test_that("collapse_chains.mcmcr", {
  x <- collapse_chains(mcmcr)
  expect_is(x, "mcmcr")
  expect_identical(nchains(x), 1L)
  expect_identical(niters(x), niters(mcmcr) * nchains(mcmcr))
})
