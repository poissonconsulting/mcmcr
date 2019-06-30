context("nlists")

test_that("as.nlists.mcmcr", {
  expect_equal(nlist::as.nlists(subset(mcmcr::mcmcr_example, iterations = 1:4)),
                   structure(list(structure(list(alpha = c(7.17313, 8.17313), beta = structure(c(-1.5662,
-0.5662, -0.5662, 0.4338), .Dim = c(2L, 2L)), sigma = 11.2331), class = "nlist"),
    structure(list(alpha = c(2.95253, 3.95253), beta = structure(c(1.50337,
    2.50337, 2.50337, 3.50337), .Dim = c(2L, 2L)), sigma = 4.88649), class = "nlist"),
    structure(list(alpha = c(3.66989, 4.66989), beta = structure(c(0.628157,
    1.628157, 1.628157, 2.628157), .Dim = c(2L, 2L)), sigma = 1.39734), class = "nlist"),
    structure(list(alpha = c(3.31522, 4.31522), beta = structure(c(1.18272,
    2.18272, 2.18272, 3.18272), .Dim = c(2L, 2L)), sigma = 0.662879), class = "nlist"),
    structure(list(alpha = c(2.0665, 3.0665), beta = structure(c(0.94983,
    1.94983, 1.94983, 2.94983), .Dim = c(2L, 2L)), sigma = 2.85379), class = "nlist"),
    structure(list(alpha = c(2.55073, 3.55073), beta = structure(c(0.533868,
    1.533868, 1.533868, 2.533868), .Dim = c(2L, 2L)), sigma = 1.71367), class = "nlist"),
    structure(list(alpha = c(3.72809, 4.72809), beta = structure(c(0.520681,
    1.520681, 1.520681, 2.520681), .Dim = c(2L, 2L)), sigma = 0.785154), class = "nlist"),
    structure(list(alpha = c(2.90303, 3.90303), beta = structure(c(0.976253,
    1.976253, 1.976253, 2.976253), .Dim = c(2L, 2L)), sigma = 0.948167), class = "nlist")), class = "nlists"))
})

test_that("as.nlists.mcmc.list", {
  x <- subset(mcmcr::mcmcr_example, iterations = 1:4)
  expect_identical(nlist::as.nlists(coda::as.mcmc.list(x)), nlist::as.nlists(x))
})

test_that("as.nlists.mcmc", {
  x <- subset(mcmcr::mcmcr_example, chains = 1L, iterations = 1:4)
  expect_identical(nlist::as.nlists(coda::as.mcmc(x)), nlist::as.nlists(x))
})
