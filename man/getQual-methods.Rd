\name{getQual-methods}
\docType{methods}
\alias{getQual}
\alias{getQual-methods}
\alias{getQual,FASTQSummary-method}

\title{Get a Data Frame of Quality Data from a \code{FASTQSummary}
  object}

\description{
  An object of class \code{\link[=FASTQSummary-class]{FASTQSummary}} contains quality data (binned by \code{\link{readSeqFile}}). \code{\link{getQual}} is
  an accessor  function that reshapes the data into a data frame.  

  This accessor function is useful if you want to map variables to
  custom \code{ggplot2} aesthetics.
}

\usage{
getQual(x)
}

\arguments{
  \item{x}{an S4 object of class \code{FASTQSummary} from
    \code{readSeqFile}.}
}

\value{
  \code{getQual} returns a \code{data.frame} with columns:

  \item{position}{the position in the read.}
  \item{ymin}{the minimum quality found per a position in the read.}
  \item{alt.lower}{the 10\% quantile found per a position in the read.}
  \item{lower}{the 25\% quartile found per a position in the read.}
  \item{middle}{the median found per a position in the read.}
  \item{upper}{the 75\% quartile found per a position in the read.}
  \item{alt.upper}{the 90\% quantile found per a position in the read.}
  \item{ymax}{the maximum quality found per a position in the read.}
  \item{mean}{the mean quality (calculated from the binned data by using a weighted mean function)
    per the position in the read.}
}

\section{Methods}{
  \describe{
    \item{\code{signature(x="FASTQSummary")}}{
      \code{getQual} is an accessor function that only works if there is
      quality data, thus it only works with objects of class
      \code{FASTQSummary}.}
  }
}

\author{Vince Buffalo <vsbuffalo@ucdavis.edu>}
\examples{
  ## Load a FASTQ file, with sequence hashing.
  s.fastq <- readSeqFile(system.file('extdata', 'test.fastq', package='qrqc'))

  ## Mean quality by position
  p <- ggplot(getQual(s.fastq)) + geom_line(aes(x=position, y=mean), color="blue")
  p <- p + scale_y_continuous(limits=c(0, 42))
  p

  ## A different type of quality plot
  p <- ggplot(getQual(s.fastq)) + geom_linerange(aes(x=position,
    ymin=lower, ymax=upper, color=mean))
  p <- p +  scale_color_gradient("mean quality", low="red", high="green")
  p + scale_y_continuous("quality")
}
\seealso{\code{\link{getGC}}, \code{\link{getSeqlen}},
  \code{\link{getBase}}, \code{\link{getBaseProp}},
  \code{\link{getMCQual}}, \code{\link{qualPlot}}}

\keyword{methods}
\keyword{accessor}
