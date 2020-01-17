context("vld")

test_that("vld_mcmcarray", {
  expect_false(vld_mcmcarray(1))
  expect_true(vld_mcmcarray(array(1)))
  expect_true(vld_mcmcarray(as.mcmcarray(1)))
})

test_that("vld_mcmcr", {
  expect_false(vld_mcmcr(list(x = 1)))
  expect_true(vld_mcmcr(as.mcmcr(list(x = 1))))
})
