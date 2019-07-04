context("thin")

test_that("thin.mcmcarray", {
  expect_identical(thin(mcmcr_example[[1]]), mcmcr_example[[1]])
  mcmcr2t <- thin(mcmcr_example[[2]], 2L)
  expect_identical(nchains(mcmcr2t), nchains(mcmcr_example[[2]]))
  expect_equal(niters(mcmcr2t), niters(mcmcr_example[[2]]) / 2)
})

test_that("thin.mcmcr", {
  expect_identical(thin(mcmcr_example), mcmcr_example)
  mcmcr2t <- thin(mcmcr_example, 2L)
  expect_identical(nchains(mcmcr2t), nchains(mcmcr_example))
  expect_equal(niters(mcmcr2t), niters(mcmcr_example) / 2)
  expect_equal(term(mcmcr2t), term(mcmcr_example))
})

test_that("thin.mcmcrs", {
  mcmcrs <- mcmcrs(mcmcr_example, mcmcr_example)
  expect_identical(thin(mcmcrs), mcmcrs)
  mcmcrs2t <- thin(mcmcrs, 2L)
  expect_identical(nchains(mcmcrs2t), nchains(mcmcrs))
  expect_equal(niters(mcmcrs2t), niters(mcmcrs) / 2)
  expect_equal(term(mcmcrs2t), term(mcmcrs))
})
