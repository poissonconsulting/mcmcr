#' @export
universals::rhat

#' @inherit universals::rhat
#' @inheritParams params
#' @export
rhat.mcarray <- function(x, by = "all", as_df = FALSE, na_rm = FALSE, ...) {
  chk_unused(...)
  rhat(as.mcmcarray(x), by = by, as_df = as_df, na_rm = na_rm)
}

#' @inherit universals::rhat
#' @inheritParams params
#' @export
rhat.mcmc <- function(x, by = "all", as_df = FALSE, na_rm = FALSE, ...) {
  chk_unused(...)
  rhat(as.mcmcr(x), by = by, as_df = as_df, na_rm = na_rm)
}

#' @inherit universals::rhat
#' @inheritParams params
#' @export
rhat.mcmc.list <- function(x, by = "all", as_df = FALSE, na_rm = FALSE, ...) {
  chk_unused(...)
  rhat(as.mcmcr(x), by = by, as_df = as_df, na_rm = na_rm)
}

#' @inherit universals::rhat
#' @inheritParams params
#' @export
rhat.mcmcarray <- function(x, by = "all", as_df = FALSE, na_rm = FALSE, ...) {
  chk_unused(...)
  chk_string(by)
  chk_subset(by, c("all", "parameter", "term"))
  chk_flag(as_df)
  chk_flag(na_rm)

  if (niters(x) < 4) {
    if (!as_df) {
      if (by == "term") {
        return(utils::relist(NA_real_, estimates(x)))
      }
      return(NA_real_)
    }
    if (by == "term") {
      return(tibble(term = as_term(x), rhat = NA_real_))
    }
    return(tibble(parameter = "parameter", rhat = NA_real_))
  }

  x <- split_chains(x)
  x <- apply(x, 3:ndims(x), FUN = .rhat, na_rm = na_rm)

  if (!as_df) {
    if (by == "term") {
      return(x)
    }
    return(max(x))
  }
  if (by != "term") {
    return(tibble(parameter = "parameter", rhat = max(x)))
  }
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
rhat.mcmcr <- function(x, by = "all", as_df = FALSE, na_rm = FALSE, ...) {
  chk_unused(...)
  parameters <- pars(x)
  x <- lapply(x, rhat, by = by, as_df = as_df, na_rm = na_rm)
  if (!as_df) {
    if (by != "all") {
      return(x)
    }
    return(max(unlist(x)))
  }
  x <- Map(x, parameters, f = function(x, p) {
    pars(x[[1]]) <- p
    x
  })
  x <- do.call("rbind", x)
  # FIXME horrible hack to deal with
  # https://github.com/poissonconsulting/term/issues/40
  is.factor <- vapply(x, is.factor, TRUE)
  x[is.factor] <- lapply(x[is.factor], function(x) new_term(as.character(x)))
  if (by == "all") {
    return(tibble(all = "all", rhat = max(x$rhat)))
  }
  x
}

#' @inherit universals::rhat
#' @inheritParams params
#' @export
#' @examples
#' rhat(mcmcrs(mcmcr_example, mcmcr_example))
#' rhat(mcmcrs(mcmcr_example, mcmcr_example), bound = TRUE)
rhat.mcmcrs <- function(x, by = "all", as_df = FALSE, na_rm = FALSE,
                        bound = FALSE, ...) {
  chk_flag(bound)
  chk_unused(...)

  rhat <- lapply(x, rhat, by = by, as_df = as_df, na_rm = na_rm)
  if (!bound) {
    return(rhat)
  }
  lifecycle::deprecate_soft(
    "0.6.1.9001",
    I("`rhat.mcmcrs(x, bound = TRUE)` returns scalar"),
    I("`rhat(x, bound = TRUE)$bound` for previous behaviour"),
    details = "`rhat.mcmcrs(bound = TRUE)` now returns named list of scalars."
  )

  x <- Reduce(bind_chains, x)
  x <- rhat(x, by = by, as_df = as_df, na_rm = na_rm)
  rhat <- c(rhat, list(bound = x))

  name_rhat <- function(x, nm) {
    colnames(x) <- sub("^rhat$", nm, colnames(x))
    x
  }

  if (as_df) {
    by <- rhat[[1]]
    by <- by[colnames(by) != "rhat"]
    rhat <- lapply(rhat, function(x) x["rhat"])
    rhat <- mapply(stats::setNames, rhat, names(rhat), SIMPLIFY = FALSE)
    rhat <- Reduce(cbind, c(list(by = by), rhat))
  }
  return(rhat)
}
