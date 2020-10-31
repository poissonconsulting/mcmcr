test_that("tidy.mcmcr", {
  x <- subset(mcmcr::mcmcr_example, iters = 1:2)
  expect_identical(tidy(x, simplify = TRUE), tidy(nlist::as_mcmc_list(x), simplify = TRUE))
})
