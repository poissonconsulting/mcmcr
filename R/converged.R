#' Object Converged
#'
#' Test whether an object has converged.
#'
#' @inheritParams params
#' @seealso \code{\link{rhat}} and \code{\link{esr}}
#' @export
#' @examples
#' converged(mcmcr_example)
#' converged(mcmcrs(mcmcr_example, mcmcr_example))
#' converged(mcmcrs(mcmcr_example, mcmcr_example), bound = TRUE)
converged <- function(x, ...) UseMethod("converged")

#' @describeIn converged Default Converged
#' @export
converged.default <- function(x, rhat = 1.1, esr = 0.33, by = "all", as_df = FALSE,
                              ...) {
  chk_number(rhat)
  chk_range(rhat, c(1, 10))
  chk_number(esr)
  chk_range(esr)
  chk_unused(...)

  esrs <- esr(x, by = by, as_df = as_df)
  rhats <- rhat(x, by = by, as_df = as_df)

  if(as_df) {
    converged <- esrs
    converged$converged <- converged$esr >= esr
    converged$esr <- NULL
    converged$converged <- converged$converged & rhats$rhat <= rhat
    return(converged)
  }
  converged <- unlist(esrs)
  converged <- converged >= esr
  rhats <- unlist(rhats)
  converged <- converged & rhats <= rhat
  utils::relist(converged, esrs)
}

#' @export
converged.mcmcrs <- function(x, rhat = 1.1, esr = 0.33, by = "all", as_df = FALSE,
                             bound = FALSE, ...) {
  chk_flag(bound)
  chk_unused(...)
  if(bound) {
    x <- Reduce(bind_chains, x)
    return(converged(x, rhat = rhat, esr = esr, by = by, as_df = as_df))
  }
  lapply(x, converged, rhat = rhat, esr = esr, by = by, as_df = as_df)
}
