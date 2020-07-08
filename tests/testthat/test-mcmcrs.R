test_that("mcmcrs", {
  mcmcrs <- mcmcrs(mcmcr_example, mcmcr_example)
  expect_identical(length(mcmcrs), 2L)
  expect_identical(names(mcmcrs), c("mcmcr1", "mcmcr2"))
  mcmcrs <- mcmcrs(mc1 = mcmcr_example, mc2 = mcmcr_example)
  expect_identical(names(mcmcrs), c("mc1", "mc2"))
})
