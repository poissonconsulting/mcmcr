context("plot")

test_that("plot.mcmcarray", {
  pdf(tempfile())
  expect_null(plot(mcmcr_example[[1]]))
  dev.off()
})

test_that("plot.mcmcarray", {
  pdf(tempfile())
  expect_null(plot(mcmcr_example))
  dev.off()
})
