context("split_chains")

test_that("split_chains.mcmcarray", {
  x <- split_chains(mcmcr_example[[2]])
  expect_is(x, "mcmcarray")
  expect_identical(nchains(x), 4L)
  expect_identical(nsims(x), nsims(mcmcr_example[[2]]))
})

test_that("collapse_chains.mcmcr", {
  x <- split_chains(mcmcr_example)
  expect_is(x, "mcmcr")
  expect_identical(nchains(x), 4L)
  expect_identical(nsims(x), nsims(mcmcr_example))
})

test_that("collapse_chains.mcmcr2", {
  x <- split_chains(mcmcr_example2)
  expect_is(x, "mcmcr")
  expect_identical(nchains(x), 4L)
  expect_identical(nsims(x), nsims(mcmcr_example2))
})

