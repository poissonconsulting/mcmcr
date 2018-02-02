check_mcmcr_data <- function(mcmcr_data){
  stopifnot(identical(names(mcmcr_data), c("mcmcr", "data")))

  mcmcr <- mcmcr_data$mcmcr
  data <- mcmcr_data$data

  if (!is.mcmcr(mcmcr)) error("mcmcr must be of class mcmcr")
  check_data(data)

  if (length(parameters(mcmcr)) != 1) error("mcmcr must have just one parameter")

  if (ndims(mcmcr[[1]]) != 3) error("mcmcr's parameter must be a vector")
  if (dims(mcmcr[[1]])[3] != nrow(data)) error("mcmcr's parameter must be the same length as the number of rows in data")

  mcmcr_data
}
