context("convergence")

test_that("convergence.mcmcmarray", {
  expect_equal(convergence(mcmcr[[1]]), c(1.732703, 1.732703), tolerance = 1e-06)
  expect_equal(convergence(mcmcr[[2]]), matrix(c(1.731738, 1.731738, 1.731312, 1.731312), nrow = 2), check.attributes = FALSE, tolerance = 1e-06)
  expect_equal(convergence(mcmcr[[3]]), c(1.734326), tolerance = 1e-06)
})
