#' Parameter descriptions
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
#' @param as_df A flag indicating whether to return the results as a
#' data frame versus a named list.
#' @param fun A function that given a numeric vector returns a numeric scalar.
#' @param bound flag specifying whether to bind mcmcrs objects by their chains before calculating rhat.
#' @param rhat The maximum rhat value.
#' @param esr The minimum effective sampling rate.
#' @param na_rm A flag specifying whether to ignore missing values.
#' @param parameters A character vector (or NULL) of the parameters to subset by.
#' @param iterations An integer vector (or NULL) of the iterations to subset by.
#' @param ... Unused.
#' @param x2 a second MCMC object.
#' @param x_name A string of the name of the object.
#' @param error A flag indicating whether to throw an informative error or immediately generate an informative message if the check fails.
#' @param sorted A flag specifying whether the parameters must be sorted.
#' @param object The MCMC object to get the coefficients for
#' @param conf_level A number specifying the confidence level. By default 0.95.
#' @param estimate The function to use to calculate the estimate.
#' @param simplify A flag specifying whether to return just the estimate, lower, upper and svalue.
#' @param perm A integer vector of the new order for the parameter dimensions.
#' @param pars A character vector (or NULL) of the pars to zero.
#' @param name A string specifying the parameter name.
#' @name params
NULL
