test_that("print.mcmcarray", {
  expect_output(print(mcmcr_example[[1]]))
})

test_that("print.mcmcr", {
  expect_output(print(mcmcr_example))
})

test_that("print.mcmcr", {
  expect_output(print(as_term(mcmcr_example)))
})
