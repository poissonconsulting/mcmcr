test_that("tidy.mcmc", {
  nlists <- nlists(nlist(x = 1:3, y = matrix(1)))
  expect_identical(tidy(as.mcmc(nlists)), tidy(nlists))
})

test_that("tidy.mcmc.list", {
  nlists <- nlists(nlist(x = 1:3, y = matrix(1)))
  expect_identical(tidy(as.mcmc.list(nlists)), tidy(nlists))
})
