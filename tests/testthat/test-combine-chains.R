context("combine_chains")

test_that("combine_chains", {

  x <- mcmcr[[1]]
  x2 <- mcmcr[[1]]

  x <- combine_chains(x, x2)

  expect_is(x, "mcmcarray")
  expect_identical(dim(x)[-1], dim(x2)[-1])
  expect_identical(dim(x)[1], dim(x2)[1] * 2L)
})
