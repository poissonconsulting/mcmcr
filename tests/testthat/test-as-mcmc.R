test_that("as.mcmc", {
  expect_error(
    coda::as.mcmc(mcmcr_example$alpha),
    "^`nchains\\(x\\)` must be identical to 1L\\.",
    class = "chk_error"
  )

  expect_s3_class(
    as.mcmc(as.mcarray(coda::as.mcmc.list(collapse_chains(mcmcr_example[[
      1
    ]])))),
    "mcmc"
  )
})

test_that("as.mcmc on an nlists object dispatches to nlist", {
  x <- nlist::nlists(nlist::nlist(a = 1), nlist::nlist(a = 2))

  expect_s3_class(as.mcmc(x), "mcmc")
  expect_identical(as.vector(as.mcmc(x)), c(1, 2))
  expect_error(
    as.mcmc(x, bogus = 1),
    "^`[.][.][.]` must be unused[.]$",
    class = "chk_error"
  )
})
