.onLoad <- function(...) {
  register_s3_method("stats", "terms", "mcmcarray")
  register_s3_method("stats", "terms", "mcmcr")
  register_s3_method("stats", "coef", "mcmcarray")
  register_s3_method("stats", "coef", "mcmcr")
  register_s3_method("graphics", "plot", "mcmcarray")
  register_s3_method("graphics", "plot", "mcmcr")
  register_s3_method("coda", "as.mcmc.list", "mcmc")
  register_s3_method("coda", "as.mcmc.list", "mcmc.list")
  register_s3_method("coda", "as.mcmc.list", "mcarray")
  register_s3_method("coda", "as.mcmc.list", "mcmcarray")
  register_s3_method("coda", "as.mcmc.list", "mcmcr")
  register_s3_method("coda", "as.mcmc", "mcmc")
  register_s3_method("coda", "as.mcmc", "mcmc.list")
  register_s3_method("coda", "as.mcmc", "mcarray")
  register_s3_method("coda", "as.mcmc", "mcmcarray")
  register_s3_method("coda", "as.mcmc", "mcmcr")
  register_s3_method("coda", "thin", "mcmc")
  register_s3_method("coda", "thin", "mcmc.list")
  register_s3_method("coda", "thin", "mcmcarray")
  register_s3_method("coda", "thin", "mcmcr")
  register_s3_method("coda", "thin", "mcmcrs")
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
