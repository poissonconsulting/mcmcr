test_that("as.mcmcrs", {
  expect_is(as.mcmcrs(list(mcmcr_example, mcmcr_example)), "mcmcrs")
  expect_identical(
    as.mcmcrs(as.mcmcrs(list(mcmcr_example, mcmcr_example))),
    as.mcmcrs(list(mcmcr_example, mcmcr_example))
  )
})
