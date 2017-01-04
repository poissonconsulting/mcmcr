context("print")

test_that("print.mcmcarray", {
  expect_output(print(mcmcr[[1]]))
})
