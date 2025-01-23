save_csv <- function(x) {
  path <- tempfile(fileext = ".csv")
  utils::write.csv(x, path, quote = FALSE, row.names = FALSE)
  path
}

expect_snapshot_data <- function(x, name, digits = 6) {
  fun <- function(x) signif(x, digits = digits)
  x <- as.list(x) |>
  x <- purrr::map_if(x, .p = is.numeric, .f = signif, digits = digits)
  x <- as.data.frame(x)
  path <- save_csv(x)
  testthat::expect_snapshot_file(
    path,
    paste0(name, ".csv"),
    compare = testthat::compare_file_text
  )
}
