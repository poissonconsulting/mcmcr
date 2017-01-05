context("bind_iterations")

test_that("bind_iterations.mcmcarray", {

  x <- mcmcr[[1]]
  x2 <- mcmcr[[1]]

  x <- bind_iterations(x, x2)

  expect_is(x, "mcmcarray")
  expect_identical(dim(x)[-2], dim(x2)[-2])
  expect_identical(dim(x)[2], dim(x2)[2] * 2L)
})

test_that("bind_iterations.mcmcr", {

  x <- mcmcr
  x2 <- mcmcr

  x <- bind_iterations(x, x2)

  expect_is(x, "mcmcr")
  expect_identical(parameters(x), parameters(x2))
  expect_identical(niters(x), niters(x2) * 2L)
  expect_identical(nchains(x), nchains(x2))
})
