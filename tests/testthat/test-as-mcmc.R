context("as.mcmc")

test_that("as.mcmc", {
  expect_error(coda::as.mcmc(mcmcr_example$alpha),
               "^`nchains[(]x[)]` must be identical to: 1L[.]$",
               class = "chk_error")

  expect_is(as.mcmc(as.mcarray(coda::as.mcmc.list(collapse_chains(mcmcr_example[[1]])))),
            "mcmc")
})
