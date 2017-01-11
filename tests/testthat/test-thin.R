context("thin")

test_that("thin.mcmcarray", {
  expect_identical(thin(mcmcr[[1]]), mcmcr[[1]])
  mcmcr2t <- thin(mcmcr[[2]], 2L)
  expect_identical(nchains(mcmcr2t), nchains(mcmcr[[2]]))
  expect_equal(niters(mcmcr2t), niters(mcmcr[[2]]) / 2)
})

test_that("thin.mcmcr", {
  expect_identical(thin(mcmcr), mcmcr)
  expect_identical(thin(mcmcr, 0L), mcmcr)
  mcmcr2t <- thin(mcmcr, 2L)
  expect_identical(nchains(mcmcr2t), nchains(mcmcr))
  expect_equal(niters(mcmcr2t), niters(mcmcr) / 2)
  expect_equal(terms(mcmcr2t), terms(mcmcr))
})
