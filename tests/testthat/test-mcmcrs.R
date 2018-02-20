context("mcmcrs")

test_that("mcmcrs", {
  mcmcrs <- mcmcrs(mcmcr::mcmcr_example, mcmcr::mcmcr_example)
  expect_identical(length(mcmcrs), 2L)
  expect_identical(names(mcmcrs), c("mcmcr1", "mcmcr2"))
  mcmcrs <- mcmcrs(mc1 = mcmcr::mcmcr_example, mc2 = mcmcr::mcmcr_example)
  expect_identical(names(mcmcrs), c("mc1", "mc2"))
})
