context("subset")

test_that("subset.term", {
    x <- as.term(c("parm3[10]", "parm3[2]", "parm[2,2]", "parm[1,1]", "parm[2,1]", "parm[1,2]", "parm[10]", "parm3"))

  expect_identical(subset(x, parameters = "parm3"), as.term(c("parm3[10]", "parm3[2]", "parm3")))
})

test_that("subset.mcmcr", {
  expect_identical(parameters(subset(mcmcr_example, parameters = rev(parameters(mcmcr_example)))), rev(parameters(mcmcr_example)))
  expect_identical(nchains(subset(mcmcr_example, 1L)), 1L)
  expect_identical(nsims(subset(mcmcr_example, rep(1L, 5), 2:3)), 10L)
  expect_identical(nterms(subset(mcmcr_example, parameters = "beta")), 4L)
})

test_that("subset.mcmc.list", {
  expect_identical(parameters(subset(coda::as.mcmc.list(mcmcr_example), parameters = "beta")), "beta")
  expect_identical(niters(subset(coda::as.mcmc.list(mcmcr_example), iterations = 10L)), 1L)
  expect_identical(nchains(subset(coda::as.mcmc.list(mcmcr_example), chains = 2L)), 1L)
})
