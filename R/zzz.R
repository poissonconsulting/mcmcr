.onLoad <- function(...) {
  register_s3_method("stats", "terms", "mcmcarray")
  register_s3_method("stats", "terms", "mcmcr")
  register_s3_method("stats", "coef", "mcmcarray")
  register_s3_method("stats", "coef", "mcmcr")
  register_s3_method("graphics", "plot", "mcmcarray")
  register_s3_method("graphics", "plot", "mcmcr")
  invisible()
}

register_s3_method <- function(pkg, generic, class) {
  stopifnot(is.character(pkg), length(pkg) == 1)
  stopifnot(is.character(generic), length(generic) == 1)
  stopifnot(is.character(class), length(class) == 1)

  fun <- get(paste0(generic, ".", class), envir = parent.frame())

  if (pkg %in% loadedNamespaces())
    registerS3method(generic, class, fun, envir = asNamespace(pkg))

  setHook(
    packageEvent(pkg, "onLoad"),
    function(...) {
      registerS3method(generic, class, fun, envir = asNamespace(pkg))
    }
  )
}
