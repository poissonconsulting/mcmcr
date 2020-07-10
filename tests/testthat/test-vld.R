test_that("vld_mcmcarray", {
  expect_true(vld_mcmcarray(as.mcmcarray(1)))
  expect_false(vld_mcmcarray(structure(1, class = "mcmcarray")))
  expect_false(vld_mcmcarray(structure(TRUE, .Dim = 1L, class = "mcmcarray")))

  x <- array(TRUE)
  class(x) <- "mcmcarray"
  expect_error(chk_mcmcarray(x), "^`x` must be numeric[.]$",
    class = "chk_error"
  )

  expect_false(vld_mcmcarray(1))
  expect_false(vld_mcmcarray(array(1)))
  expect_true(vld_mcmcarray(as.mcmcarray(1)))
})

test_that("vld_mcmcr", {
  expect_false(vld_mcmcr(list(x = 1)))
  expect_true(vld_mcmcr(as.mcmcr(list(x = 1))))
})
