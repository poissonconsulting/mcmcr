context("nsims")

test_that("nsims", {
  expect_identical(nsims(mcmcr_example), 400L)
})
