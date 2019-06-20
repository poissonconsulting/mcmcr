context("as")

test_that("as.mcarray", {
  mcarrays <- lapply(mcmcr_example, as.mcarray)
  mcmcarrays <- lapply(mcarrays, as.mcmcarray)
  expect_equal(mcmcarrays, unclass(mcmcr_example), check.attributes = FALSE)
  mcarrays2 <- lapply(mcmcarrays, as.mcarray)
  expect_equal(mcarrays2, mcarrays)
  expect_equal(mcarrays[[1]], as.mcarray(mcarrays[[1]]))

  expect_error(as.mcarray(coda::as.mcmc.list(mcmcr_example)),
               "x must only have 1 parameter")

  expect_is(as.mcarray(coda::as.mcmc.list(mcmcr_example[[1]])), "mcarray")
  expect_is(as.mcarray(as.mcarray(coda::as.mcmc.list(mcmcr_example[[1]]))), "mcarray")
})

test_that("as.mcmc", {
  expect_error(coda::as.mcmc(mcmcr_example$alpha),
               "x must only have 1 chain")


  expect_is(as.mcmc(as.mcarray(coda::as.mcmc.list(collapse_chains(mcmcr_example[[1]])))),
            "mcmc")
})

test_that("as.mcmc.list", {
  mcmc.list <- coda::as.mcmc.list(mcmcr_example)
  expect_is(mcmc.list, "mcmc.list")

  expect_identical(coda::nchain(mcmc.list), 2L)
  expect_identical(coda::nvar(mcmc.list), 7L)
  expect_equal(as.mcmcr(mcmc.list), mcmcr_example, check.attributes = FALSE)
})

test_that("as.mcmcr", {
  expect_identical(as.mcmcr(as.list(mcmcr_example)), mcmcr_example)
  expect_identical(as.mcmcr(mcmcr_example), mcmcr_example)
})

test_that("as.mcmcrs", {
  expect_is(as.mcmcrs(list(mcmcr_example, mcmcr_example)), "mcmcrs")
  expect_identical(as.mcmcrs(as.mcmcrs(list(mcmcr_example, mcmcr_example))),
                   as.mcmcrs(list(mcmcr_example, mcmcr_example)))

})

test_that("as.term", {
  term <- as.term(coda::as.mcmc.list(mcmcr_example))
  expect_identical(term,
                   structure(c("alpha[1]", "alpha[2]", "beta[1,1]", "beta[2,1]",
                               "beta[1,2]", "beta[2,2]", "sigma"), class = c("term", "character"
                               )))
})
