% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/utils.R
\name{ess}
\alias{ess}
\title{P-Value
effective sample size}
\usage{
ess(x, by = "all", as_df = FALSE)
}
\arguments{
\item{x}{An MCMC object.}

\item{by}{A string indicating whether to determine by
"term", "parameter" or "all".}

\item{as_df}{A flag indicating whether to return the results as a
data frame versus a named list.}
}
\description{
Calculates the effective sample size based on \code{\link[=esr]{esr()}}.
}
\examples{
ess(mcmcr_example)
}
\seealso{
\link[universals:esr]{universals::esr}
}
