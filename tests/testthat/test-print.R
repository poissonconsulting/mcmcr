context("print")

test_that("print.mcmcarray", {
  expect_output(print(mcmcr_example[[1]]))
})
