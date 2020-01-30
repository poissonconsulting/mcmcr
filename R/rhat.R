#' @export
universals::rhat

#' @inherit universals::rhat
#' @inheritParams params
#' @export
rhat.mcarray <- function(x, by = "all", as_df = FALSE, ...) {
  chk_unused(...)
  rhat(as.mcmcarray(x), by = by, as_df = as_df)
}

#' @inherit universals::rhat
#' @inheritParams params
#' @export
rhat.mcmc <- function(x, by = "all", as_df = FALSE, ...) {
  chk_unused(...)
  rhat(as.mcmcr(x), by = by, as_df = as_df)
}

#' @inherit universals::rhat
#' @inheritParams params
#' @export
rhat.mcmc.list <- function(x, by = "all", as_df = FALSE, ...) {
  chk_unused(...)
  rhat(as.mcmcr(x), by = by, as_df = as_df)
}

#' @inherit universals::rhat
#' @inheritParams params
#' @export
rhat.mcmcarray <- function(x, by = "all", as_df = FALSE, ...) {
  chk_unused(...)
  chk_string(by)
  chk_subset(by, c("all", "parameter", "term"))
  chk_flag(as_df)

  if(niters(x) < 4) {
    if(!as_df) {
      if(by == "term") return(utils::relist(NA_real_, estimates(x)))
      return(NA_real_)
    }
    if(by == "term")
      return(tibble(term = as.term(x), rhat = NA_real_))
    return(tibble(parameter = "parameter", rhat = NA_real_))
  }

  x <- split_chains(x)
  x <- apply(x, 3:ndims(x), FUN = .rhat)

  if(!as_df) {
    if(by == "term") return(x)
    return(max(x))
  }
  if(by != "term")
    return(tibble(parameter = "parameter", rhat = max(x)))
  x <- estimates(as.mcmcarray(x), as_df = TRUE)
  colnames(x) <- c("term", "rhat")
  x
}

#' @inherit universals::rhat
#' @inheritParams params
#' @export
#' @examples
#' rhat(mcmcr_example)
#' rhat(mcmcr_example, by = "parameter")
#' rhat(mcmcr_example, by = "term")
#' rhat(mcmcr_example, by = "term", as_df = TRUE)
rhat.mcmcr <- function(x, by = "all", as_df = FALSE, ...) {
  chk_unused(...)
  parameters <- pars(x)
  x <- lapply(x, rhat, by = by, as_df = as_df)
  if(!as_df) {
    if (by != "all") return(x)
    return(max(unlist(x)))
  }
  x <- Map(x, parameters, f = function(x, p) { pars(x[[1]]) <- p; x})
  x <- do.call(rbind, x)
  if (by == "all")
    return(tibble(all = "all", rhat = max(x$rhat)))
  x
}

#' @inherit universals::rhat
#' @inheritParams params
#' @export
#' @examples
#' rhat(mcmcrs(mcmcr_example, mcmcr_example))
#' rhat(mcmcrs(mcmcr_example, mcmcr_example), bound = TRUE)
rhat.mcmcrs <- function(x, by = "all", as_df = FALSE,
                        bound = FALSE, ...) {
  chk_flag(bound)
  chk_unused(...)

  if(bound) {
    x <- Reduce(bind_chains, x)
    return(rhat(x, by = by, as_df = as_df))
  }
  lapply(x, rhat, by = by, as_df = as_df)
}
