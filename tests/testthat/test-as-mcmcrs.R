test_that("as.mcmcrs", {
  expect_s3_class(as.mcmcrs(list(mcmcr_example, mcmcr_example)), "mcmcrs")
  expect_identical(
    as.mcmcrs(as.mcmcrs(list(mcmcr_example, mcmcr_example))),
    as.mcmcrs(list(mcmcr_example, mcmcr_example))
  )
})
