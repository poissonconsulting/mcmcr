test_that("as_nlists.mcmc", {
  nlists <- nlist::nlists(
    nlist::nlist(x = 1, y = matrix(1:4, 2)),
    nlist::nlist(x = 3, y = matrix(4:1, 2))
  )
  expect_equal(nlist::as_nlists(nlist::as_mcmc(nlists)), nlists)
})

test_that("as_nlists.mcmc.list", {
  nlists <- nlist::nlists(
    nlist::nlist(x = 1, y = matrix(1:4, 2)),
    nlist::nlist(x = 3, y = matrix(4:1, 2))
  )
  expect_equal(as_nlists(nlist::as_mcmc_list(nlists)), nlists)
})

test_that("as_nlists.mcmcr", {
  nlists <- nlist::nlists(
    nlist::nlist(x = 1, y = matrix(1:4, 2)),
    nlist::nlist(x = 3, y = matrix(4:1, 2))
  )
  expect_identical(nlist::as_nlists(as.mcmcr(nlists)), nlists)
})
