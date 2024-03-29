% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/as-mcarray.R, R/as-mcmcr.R
\name{as.mcarray}
\alias{as.mcarray}
\alias{as.mcmcr.list}
\title{Coerce to an mcarray object}
\usage{
as.mcarray(x, ...)

\method{as.mcmcr}{list}(x, ...)
}
\arguments{
\item{x}{object to coerce.}

\item{...}{Unused.}
}
\description{
Coerces MCMC objects to an mcarray object.
}
\section{Functions}{
\itemize{
\item \code{as.mcmcr(list)}: Convert a list of uniquely named objects that can be coerced to \verb{[mcmcarray-object]s} to an mcmcr object

}}
\examples{
as.mcarray(mcmcr_example$beta)
}
\seealso{
Other coerce: 
\code{\link{as.mcmcarray}()},
\code{\link{as.mcmcr}()},
\code{\link{mcmcrs}()}
}
\concept{coerce}
