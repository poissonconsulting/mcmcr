#' Parameter Descriptions
#'
#' @param x An object.
#' @param scalar A logical scalar specifying whether to include
#' all parameters (NULL), only scalars (TRUE) or all parameters
#' except scalars (FALSE).
#' @param terms A logical scalar specifying whether to provide the parameters for each term.
#' @param nas A flag specifying whether to also fill missing values.
#' @param nthin A positive integer of the thinning rate.
#' @param by A string indicating whether to determine by
#' "term", "parameter" or "all".
#' @param as_df A flag indicating whether to return the values as a
#' data frame versus a named list.
#' @param fun A function that given a numeric vector returns a numeric scalar.
#' @param bound flag specifying whether to bind mcmcrs objects by their chains before calculating rhat.
#' @param rhat The maximum rhat value.
#' @param esr The minimum effective sampling rate.
#' @param na_rm A flag specifying whether to ignore missing values.
#' @param ... Unused.
#' @name params
NULL
