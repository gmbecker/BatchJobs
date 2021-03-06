% Generated by roxygen2 (4.1.1): do not edit by hand
% Please edit documentation in R/showStatus.R
\name{showStatus}
\alias{getStatus}
\alias{showStatus}
\title{Retrieve or show status information about jobs.}
\usage{
showStatus(reg, ids, run.and.exp = TRUE, errors = 10L)

getStatus(reg, ids, run.and.exp = TRUE)
}
\arguments{
\item{reg}{[\code{\link{Registry}}]\cr
Registry.}

\item{ids}{[\code{integer}]\cr
Ids of selected jobs.
Default is all jobs.}

\item{run.and.exp}{[\code{logical(1)}]\cr
Show running and expired jobs?
Requires to list the job on the batch system. If not possible, because
that cluster function is not avilable, this option is ignored anyway.
Default is \code{TRUE}.}

\item{errors}{[\code{integer(1)}]\cr
How many of the error messages should be displayed if any errors occured in the jobs?
Default is 10.}
}
\value{
[\code{list}]. List of absolute job numbers. \code{showStatus} returns them
  invisibly.
}
\description{
E.g.: How many there are, how many are done, any errors, etc.
\code{showStatus} displays on the console, \code{getStatus} returns an informative result
without console output.
}
\examples{
reg = makeRegistry(id = "BatchJobsExample", file.dir = tempfile(), seed = 123)
f = function(x) x^2
batchMap(reg, f, 1:10)
submitJobs(reg)
waitForJobs(reg)

# should show 10 submitted jobs, which are all done.
showStatus(reg)
}

