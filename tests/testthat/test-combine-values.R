context("combine_values")

test_that("combine_values.mcmcarray", {

  x <- mcmcr[[1]]
  x2 <- mcmcr[[1]]

  x <- combine_values(x, x2, mean)

  expect_is(x, "mcmcarray")
  expect_equal(x, x2, check.attributes = FALSE)

  x <- combine_values(x, x2, sum)
  expect_equal(x[1,1,1], x2[1,1,1] * 2)

  expect_identical(combine_values(x, x2), combine_values_list(list(x, x2)))
})

test_that("combine_values.mcmr", {

  x <- mcmcr
  x2 <- mcmcr

  x <- combine_values(x, x2, mean)

  expect_is(x, "mcmcr")
  expect_equal(x, x2, check.attributes = FALSE)

  x <- combine_values(x, x2, sum)
  expect_equal(x$alpha[1,1,1], x2$alpha[1,1,1] * 2)
  expect_equal(combine_values(x, x2), combine_values_list(list(x, x2)))
})

test_that("combine_values.mcmcr_data", {

  data <- dplyr::data_frame(col1 = 1:2, col2 = 3)

  mcmcr <- subset(mcmcr, parameters = "alpha")

  x <- mcmcr_data(mcmcr, data)

  data$col1 <- 2L

  x2 <- mcmcr_data(mcmcr, data)

  y <- combine_values(x, x2, by = c("col1", "col2"))
  expect_is(y, "mcmcr_data")

  expect_identical(y$data$col1, x2$data$col1)

  data$col1 <- 3L

  x2 <- mcmcr_data(mcmcr, data)

  expect_error(combine_values(x, x2, by = c("col1", "col2")))

  data$col1 <- 2L

  x2 <- mcmcr_data(mcmcr, data)
  x2 <- slice(x2, 1)

  y <- combine_values(x, x2, by = c("col1"))
  expect_identical(colnames(y$data), c("col1", "col2.x", "col2.y"))
  expect_identical(y$data$col1, 2L)

  expect_identical(combine_values(y, y), combine_values_list(list(y, y)))
})

