test_that("ess.mcmcmarray", {
  expect_identical(ess(mcmcr_example[[1]], by = "term"), c(9L, 9L))
  expect_equal(ess(mcmcr_example[[2]], by = "term"), matrix(c(40L, 40L, 40L, 40L), nrow = 2))
  expect_identical(ess(mcmcr_example[[3]], by = "term"), c(378L))
  expect_identical(ess(mcmcr_example[[2]]), 40L)
  expect_identical(ess(mcmcr_example[[1]], "parameter"), ess(mcmcr_example[[1]], "all"))
})

test_that("ess.mcmcr", {
  expect_identical(ess(mcmcr_example2), 9L)
  expect_identical(ess(mcmcr_example), 9L)
  expect_identical(ess(mcmcr_example, by = "parameter"), list(alpha = 9L, beta = 40L, sigma = 378L))
})

test_that("ess.mcmcr as df", {
  expect_identical(
    ess(mcmcr_example, as_df = TRUE),
    structure(list(all = "all", ess = 9L), row.names = c(NA, -1L), class = c(
      "tbl_df",
      "tbl", "data.frame"
    ))
  )
  expect_snapshot_data(
    ess(mcmcr_example, as_df = TRUE, by = "parameter"),
    "ess"
  )
})

test_that("ess.mcmcr constant", {
  x <- mcmcr::mcmcr_example
  x$sigma[, , 1] <- 0

  expect_identical(ess(x$sigma), 800L)
  expect_identical(ess(x), 9L)
})

test_that("ess.mcmcarray constant", {
  x <- structure(rep(-0.75377180237638, 300), dim = c(3L, 100L, 1L), class = "mcmcarray")
  expect_identical(ess(x), 300L)
  x <- structure(rep(-0.75377180237638, 30), dim = c(3L, 10L, 1L), class = "mcmcarray")
  expect_identical(ess(x), 30L)
})
