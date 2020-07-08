test_that("anyNA false", {
  expect_false(anyNA(mcmcr_example))
  expect_false(anyNA(mcmcr_example[[1]]))
  expect_false(anyNA(as.mcarray(mcmcr_example[[1]])))
  expect_false(anyNA(mcmcrs(mcmcr_example, mcmcr_example)))
  expect_false(anyNA(as.mcmc.list(mcmcr_example)))
  expect_false(anyNA(as.mcmc.list(mcmcr_example)[[1]]))
})

test_that("anyNA true", {
  mcmcr_example[[1]][1,1,] <- NA
  expect_true(anyNA(mcmcr_example))
  expect_true(anyNA(mcmcr_example[[1]]))
  expect_true(anyNA(as.mcarray(mcmcr_example[[1]])))
  expect_true(anyNA(mcmcrs(mcmcr_example, mcmcr_example)))
  expect_true(anyNA(as.mcmc.list(mcmcr_example)))
  expect_true(anyNA(as.mcmc.list(mcmcr_example)[[1]]))
})
