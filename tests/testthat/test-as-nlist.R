test_that("as_nlist.mcmc", {
  nlist <- nlist::nlist(x = 1, y = matrix(1:4, 2))
  expect_equal(nlist::as_nlist(coda::as.mcmc(nlist)), nlist)
})

test_that("as_nlist.mcmc.list", {
  nlist <- nlist::nlist(x = 1, y = matrix(1:4, 2))
  expect_equal(nlist::as_nlist(coda::as.mcmc.list(nlist)), nlist)
})

test_that("as_nlist.mcmcr", {
  nlist <- nlist::nlist(x = 1, y = matrix(1:4, 2))
  expect_identical(nlist::as_nlist(as.mcmcr(nlist)), nlist)
})
