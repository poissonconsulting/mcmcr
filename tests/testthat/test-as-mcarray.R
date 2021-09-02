test_that("as.mcarray", {
  mcarrays <- lapply(mcmcr_example, as.mcarray)
  mcmcarrays <- lapply(mcarrays, as.mcmcarray)
  expect_equal(mcmcarrays, unclass(mcmcr_example), ignore_attr = FALSE)
  mcarrays2 <- lapply(mcmcarrays, as.mcarray)
  expect_equal(mcarrays2, mcarrays)
  expect_equal(mcarrays[[1]], as.mcarray(mcarrays[[1]]))

  expect_error(as.mcarray(coda::as.mcmc.list(mcmcr_example)),
    "^`x` must only have 1 parameter[.]$",
    class = "chk_error"
  )

  expect_s3_class(as.mcarray(coda::as.mcmc.list(mcmcr_example[[1]])), "mcarray")
  expect_s3_class(as.mcarray(as.mcarray(coda::as.mcmc.list(mcmcr_example[[1]]))), "mcarray")
})
