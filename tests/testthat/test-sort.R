context("sort")

test_that("sort", {
  mcmcr_example2 <- subset(mcmcr_example, parameters = rev(pars(mcmcr_example)))
  expect_false(identical(mcmcr_example2, mcmcr_example))
  mcmcr_example2 <- sort(mcmcr_example2)
  expect_identical(mcmcr_example2, mcmcr_example)
  expect_identical(sort(mcmcrs(mcmcr_example))[[1]], mcmcr_example)
})

