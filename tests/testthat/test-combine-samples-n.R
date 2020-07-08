test_that("combine_samples_n.mcmcarray", {
  expect_identical(combine_samples_n(mcmcr_example$beta), mcmcr_example$beta)

  expect_equal(combine_samples_n(list(mcmcr_example$beta, mcmcr_example$beta, mcmcr_example$beta)), mcmcr_example$beta, check.attributes = FALSE)

  expect_equal(combine_samples_n(list(mcmcr_example$beta, mcmcr_example$beta, mcmcr_example$beta), mcmcr_example$beta), mcmcr_example$beta, check.attributes = FALSE)

  expect_equal(combine_samples_n(mcmcr_example$beta, mcmcr_example$beta, mcmcr_example$beta), mcmcr_example$beta, check.attributes = FALSE)
  x <- combine_samples_n(mcmcr_example$beta, mcmcr_example$beta,  mcmcr_example$beta, fun = sum)
  expect_equal(x[1,,,], mcmcr_example$beta[1,,,] * 3)
})

test_that("combine_samples_n.mcmcr", {
  expect_identical(combine_samples_n(mcmcr_example), mcmcr_example)

  expect_equal(combine_samples_n(list(mcmcr_example, mcmcr_example, mcmcr_example)), mcmcr_example, check.attributes = FALSE)

  expect_equal(combine_samples_n(list(mcmcr_example, mcmcr_example, mcmcr_example), mcmcr_example), mcmcr_example, check.attributes = FALSE)

  expect_equal(combine_samples_n(mcmcr_example, mcmcr_example, mcmcr_example), mcmcr_example, check.attributes = FALSE)
  x <- combine_samples_n(mcmcr_example, mcmcr_example,  mcmcr_example, fun = sum)
  expect_equal(x$beta[1,,,], mcmcr_example$beta[1,,,] * 3)
})

