test_that("as_nlist.mcmcr", {
  nlist <- nlist::nlist(x = 1, y = matrix(1:4, 2))
  expect_equal(nlist::as_nlist(as.mcmcr(nlist)), nlist)
})
