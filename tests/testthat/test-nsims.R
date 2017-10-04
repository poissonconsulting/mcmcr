context("nsims")

test_that("nsims", {
  expect_identical(nsims(list_mcarrays[[1]]), 2000L)
  expect_identical(nsims(mcmcr), 2000L)
  expect_identical(nsims(mcmcr[[1]]), 2000L)
})
