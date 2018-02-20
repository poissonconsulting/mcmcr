context("nsams")

test_that("nsams", {
  expect_identical(nsams(mcmcr_example), 2800L)
})
