context("plot")

test_that("plot.mcmcarray", {
  pdf(tempfile())
  expect_null(plot(mcmcr[[1]]))
  dev.off()
})
