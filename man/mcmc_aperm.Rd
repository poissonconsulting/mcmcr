% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/mcmc-aperm.R
\name{mcmc_aperm}
\alias{mcmc_aperm}
\title{MCMC object transposition}
\usage{
mcmc_aperm(x, perm, ...)
}
\arguments{
\item{x}{The MCMC object to transpose.
Missing parameter dimensions are added on the end.
If perm = NULL (the default) the parameter dimensions are reversed.}

\item{perm}{A integer vector of the new order for the parameter dimensions.}

\item{...}{Unused.}
}
\value{
The modified MCMC object
}
\description{
Transpose an MCMC object by permuting its parameter dimensions.
}
\seealso{
Other manipulate: 
\code{\link{mcmc_map}()}
}
\concept{manipulate}
