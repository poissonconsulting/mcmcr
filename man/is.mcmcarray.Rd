% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/is.R
\name{is.mcmcarray}
\alias{is.mcmcarray}
\title{Is mcmcarray object}
\usage{
is.mcmcarray(x)
}
\arguments{
\item{x}{The object to test.}
}
\value{
A flag indicating whether the test was positive.
}
\description{
Tests whether an object is an \code{\link[=mcmcarray-object]{mcmcarray-object()}}.
}
\examples{
is.mcmcarray(mcmcr_example$beta)
}
\seealso{
Other is: 
\code{\link{is.mcarray}()},
\code{\link{is.mcmcrs}()},
\code{\link{is.mcmcr}()}
}
\concept{is}
