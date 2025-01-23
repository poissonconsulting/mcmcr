save_csv <- function(x) {
  path <- tempfile(fileext = ".csv")
  utils::write.csv(x, path, quote = FALSE, row.names = FALSE)
  path
}

expect_snapshot_data <- function(x, name, digits = 6) {
  fun <- function(x) signif(x, digits = digits)
  x <- x |>
    as.list() |>
    purrr::map_if(.p = is.numeric, .f = signif, digits = digits) |>
    as.data.frame()
  path <- save_csv(x)
  testthat::expect_snapshot_file(
    path,
    paste0(name, ".csv"),
    compare = testthat::compare_file_text
  )
}
