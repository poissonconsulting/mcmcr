context("cross-rhat")

test_that("cross-rhat.mcmcmarray", {
  expect_identical(cross_rhat(mcmcr[[1]], mcmcr[[1]]), c(1,1))
  mcmcr2 <- mcmcr
  mcmcr2[[1]] <- mcmcr2[[1]] + 1
  expect_identical(cross_rhat(mcmcr2[[1]], mcmcr2[[1]]), c(1,1))
  expect_identical(cross_rhat(mcmcr[[1]], mcmcr2[[1]]), c(2.53, 2.43))
})

test_that("rhat.mcmcr", {
  mcmcr2 <- mcmcr
  mcmcr2[[1]] <- mcmcr2[[1]] + 1
  expect_identical(cross_rhat(subset(mcmcr, chains = 1L), subset(mcmcr, chains = 2L)),
                   rhat(mcmcr))
  expect_identical(cross_rhat(mcmcr, mcmcr2), 2.53)
})
