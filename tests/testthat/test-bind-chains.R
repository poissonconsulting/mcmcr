context("bind_chains")

test_that("bind_chains.mcmcarray", {

  x <- mcmcr[[1]]
  x2 <- mcmcr[[1]]

  x <- bind_chains(x, x2)

  expect_is(x, "mcmcarray")
  expect_identical(dim(x)[-1], dim(x2)[-1])
  expect_identical(dim(x)[1], dim(x2)[1] * 2L)
})

test_that("bind_chains.mcmcr", {

  x <- mcmcr
  x2 <- mcmcr

  x <- bind_chains(x, x2)

  expect_is(x, "mcmcr")
  expect_identical(names(x), names(x2))
  expect_identical(niters(x), niters(x2))
  expect_identical(nchains(x), nchains(x2) * 2L)
})

