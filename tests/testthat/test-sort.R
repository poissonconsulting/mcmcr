context("sort")

test_that("sort.mcmcarray", {
  mcmcr2 <- mcmcr
  mcmcr2 <- subset(mcmcr2, parameters = rev(parameters(mcmcr2)))
  expect_false(identical(mcmcr2, mcmcr))
  mcmcr2 <- sort(mcmcr2)
  expect_identical(mcmcr2, mcmcr)
})

