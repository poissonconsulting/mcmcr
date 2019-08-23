context("as-nlists")

test_that("as.nlists.mcmc", {
  nlists <- nlist::nlists(nlist::nlist(x = 1, y = matrix(1:4, 2)),
                           nlist::nlist(x = 3, y = matrix(4:1, 2)))
  expect_equal(nlist::as.nlists(coda::as.mcmc(nlists)), nlists)
})

test_that("as.nlists.mcmc.list", {
  nlists <- nlist::nlists(nlist::nlist(x = 1, y = matrix(1:4, 2)),
                           nlist::nlist(x = 3, y = matrix(4:1, 2)))
#  expect_equal(as.nlists(coda::as.mcmc.list(nlists)), nlists)
})

test_that("as.nlists.mcmcr", {
  nlists <- nlist::nlists(nlist::nlist(x = 1, y = matrix(1:4, 2)),
                           nlist::nlist(x = 3, y = matrix(4:1, 2)))
  expect_identical(nlist::as.nlists(as.mcmcr(nlists)), nlists)
})
