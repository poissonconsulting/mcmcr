#' Parameter Descriptions
#'
#' @param x An object.
#' @param scalar A logical scalar specifying whether to only include scalar terms.
#' @param terms A logical scalar specifying whether to provide the parameters for each term.
#' @param nas A flag specifying whether to also fill missing values.
#' @param nthin A positive integer of the thinning rate.
#' @param by A string indicating whether to determine by
#' "term", "parameter" or "all".
#' @param as_df A flag indicating whether to return the values as a
#' data frame versus a named list.
#' @param bound flag specifying whether to bind mcmcrs objects by their chains before calculating rhat.
#' @param rhat The maximum rhat value.
#' @param esr The minimum effective sampling rate.
#' @param ... Unused.
#' @name params
NULL
