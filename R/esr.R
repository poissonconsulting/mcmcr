#' @export
universals::esr

#' @inherit universals::esr
#' @inheritParams params
#' @export
esr.mcarray <- function(x, by = "all", as_df = FALSE, ...) {
  chk_unused(...)
  esr(as.mcmcarray(x), by = by, as_df = as_df)
}

#' @inherit universals::esr
#' @inheritParams params
#' @export
esr.mcmc <- function(x, by = "all", as_df = FALSE, ...) {
  chk_unused(...)
  esr(as.mcmcr(x), by = by, as_df = as_df)
}

#' @inherit universals::esr
#' @inheritParams params
#' @export
esr.mcmc.list <- function(x, by = "all", as_df = FALSE, ...) {
  chk_unused(...)
  esr(as.mcmcr(x), by = by, as_df = as_df)
}

#' @inherit universals::esr
#' @inheritParams params
#' @export
esr.mcmcarray <- function(x, by = "all", as_df = FALSE, ...) {
  chk_unused(...)
  chk_string(by)
  chk_subset(by, c("all", "parameter", "term"))

  x <- apply(x, 3:ndims(x), FUN = .esr)

  if(!as_df) {
    if(by == "term") return(x)
    return(min(x))
  }
  if(by != "term")
    return(tibble(parameter = "parameter", esr = min(x)))
  x <- estimates(as.mcmcarray(x), as_df = TRUE)
  colnames(x) <- c("term", "esr")
  x
}

#' @inherit universals::esr
#' @inheritParams params
#' @export
#' @examples
#' esr(mcmcr_example)
esr.mcmcr <- function(x, by = "all", as_df = FALSE, ...) {
  chk_unused(...)

  parameters <- pars(x)
  x <- lapply(x, esr, by = by, as_df = as_df)
  if(!as_df) {
    if (by != "all") return(x)
    return(min(unlist(x)))
  }
  x <- Map(x, parameters, f = function(x, p) {pars(x[[1]]) <- p; x})
  x <- do.call("rbind", x)
  # FIXME horrible hack to deal with
  # https://github.com/poissonconsulting/term/issues/40
  is.factor <- vapply(x, is.factor, TRUE)
  x[is.factor] <- lapply(x[is.factor], function(x) new_term(as.character(x)))
  if(by == "all")
    return(tibble(all = "all", esr = min(x$esr)))
  x
}

#' @inherit universals::esr
#' @inheritParams params
#' @export
#' @examples
#' esr(mcmcrs(mcmcr_example, mcmcr_example))
esr.mcmcrs <- function(x, by = "all", as_df = FALSE, ...) {
  chk_unused(...)

  lapply(x, esr, by = by, as_df = as_df)
}
