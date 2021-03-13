test_that("as.mcmcarray.mcmc with multiple parameters", {
  expect_error(as.mcmcarray(as.mcmc(subset(mcmcr::mcmcr_example, chains = 1L))),
    "^`x` must only have 1 parameter[.]$",
    class = "chk_error"
  )
})

test_that("as.mcmcarray.mcmc", {
  mcmcarray <- subset(mcmcr::mcmcr_example, chains = 1L)$beta
  expect_identical(as.mcmcarray(coda::as.mcmc(mcmcarray)), mcmcarray)

  mcmcarray <- subset(mcmcr::mcmcr_example, chains = 1L)$sigma

  x <- coda::as.mcmc(mcmcarray)
  expect_identical(as.mcmcarray(x), mcmcarray)
  colnames(x) <- "1"
  expect_identical(expect_warning(as.mcmcarray(x)), structure(numeric(0), .Dim = c(1L, 400L, 0L), class = "mcmcarray"))
})

test_that("as.mcmcarray.mcmc with missing values", {
  mcmcarray <- subset(mcmcr::mcmcr_example, chains = 1L)$beta
  mcmc <- coda::as.mcmc(mcmcarray)
  mcmc <- mcmc[, c("parameter[1,1]", "parameter[2,1]", "parameter[2,2]")]
  mcmc2 <- coda::as.mcmc(as.mcmcarray(mcmc))
  mcmc2 <- mcmc2[, c("parameter[1,1]", "parameter[2,1]", "parameter[2,2]")]
  expect_identical(mcmc2, mcmc)
})
