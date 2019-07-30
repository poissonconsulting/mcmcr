context("as-nlist")

test_that("as.nlist.mcmc", {
  nlist <- nlist::nlist(x = 1, y = matrix(1:4, 2))
  expect_equal(nlist::as.nlist(coda::as.mcmc(nlist)), nlist)
})

test_that("as.nlist.mcmc.list", {
  nlist <- nlist::nlist(x = 1, y = matrix(1:4, 2))
  expect_equal(nlist::as.nlist(coda::as.mcmc.list(nlist)), nlist)
})

test_that("as.nlist.mcmcr", {
  nlist <- nlist::nlist(x = 1, y = matrix(1:4, 2))
  expect_identical(nlist::as.nlist(as.mcmcr(nlist)), nlist)
})
