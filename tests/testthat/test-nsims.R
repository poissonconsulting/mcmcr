test_that("nsims",{
  expect_identical(nsims(mcmcr::mcmcr_example), 800L)
  expect_identical(nsims(as.mcmc.list(mcmcr::mcmcr_example)), 800L)
  expect_identical(nsims(as.mcmc(subset(mcmcr::mcmcr_example, chains = 1L))), 400L)
  expect_identical(nsims(as.mcarray(mcmcr::mcmcr_example[[1]])), 800L)
  expect_identical(nsims(mcmcrs(mcmcr::mcmcr_example, mcmcr::mcmcr_example)), 800L)
})
