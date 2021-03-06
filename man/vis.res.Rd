
\name{vis.res}
\alias{vis.res}
\alias{pr}
\alias{rates}
\alias{fscores}
\alias{show.pr}
\alias{show.roc}
\alias{auc.pr}
\alias{auc.roc}
\title{Visualize Results}

\description{
  A group of functions to plot precision-recall and ROC curves and to compute f-scores from the 
  data.frame returned by the \code{\link{validate}} function.
}
\usage{
  pr(table)
  rates(table)
  fscores(table, beta=1)
  show.pr(table,device=-1,...)
  show.roc(table,device=-1,...)
  auc.roc(table)
  auc.pr(table)
}

\arguments{
  \item{table}{This is the  data.frame returned by the \code{validate} function where columns contain 
	  TP,FP,TN,FN values (confusion matrix) as well as the threshold value used  - see \code{\link{validate}}.}
  \item{beta}{Numeric used as the weight of the recall in the f-score formula - see details. The default value of this argument is
	1, meaning precision as important as recall.}
  \item{device}{The device to be used. This parameter allows the user to plot precision-recall and 
	   receiver operating characteristic curves for various inference algorithms on the same plotting window - see examples.}
  \item{...}{ arguments passed to \code{plot} }
}
\value{
  The function \code{show.roc} (\code{show.pr}) plots the ROC-curve (PR-curve) and returns the device associated with the plotting window.
  
  The function \code{auc.roc} (\code{auc.pr}) computes the area under the ROC-curve (PR-curve) using the trapezoidal approximation.
  
  The function \code{pr} returns a data.frame where steps is the number of thresholds used 
  in the validation process. The first column contains precisions and the second recalls - see details.
  
  The function \code{rates} also returns a data.frame where the first column contains true 
  positive rates and the second column false positive rates - see details.  

  The function \code{fscores} returns fscores according to the confusion matrices 
  contained in the 'table' argument - see details.
}

\details{
	A confusion matrix contains FP,TP,FN,FP values.
	\itemize{
	\item "true positive rate" \eqn{tpr = \frac{TP}{TN+TP}}{tpr = TP/(TN+TP)}
	\item "false positive rate" \eqn{fpr = \frac{FP}{FN+FP}}{fpr = FP/(FN+FP)}	
	\item "precision" \eqn{p = \frac{TP}{FP+TP}}{p = TP/(FP+TP)}
	\item "recall" \eqn{r = \frac{TP}{TP+FN}}{r = TP/(TP+FN)}
	\item "f-beta-score" \eqn{F_\beta = (1+\beta) \frac{p r} {r + \beta p}}{Fbeta = (1+beta) * p*r/(r + beta*p)}
}
}

\seealso{\code{\link{validate}},  \code{\link{plot}}}
\references{
 Patrick E. Meyer, Frederic Lafitte, and Gianluca Bontempi. 
 minet: A R/Bioconductor Package for Inferring Large Transcriptional Networks Using Mutual Information. BMC Bioinformatics, Vol 9,
 2008.
}
\examples{
data(syn.data)
data(syn.net)
# Inference
mr <- minet( syn.data, method="mrnet", estimator="spearman" )
ar <- minet( syn.data, method="aracne", estimator="spearman"  )
clr<- minet( syn.data, method="clr", estimator="spearman"  )
# Validation
mr.tbl <- validate(mr,syn.net)
ar.tbl <- validate(ar,syn.net)
clr.tbl<- validate(clr,syn.net)
# Plot PR-Curves
max(fscores(mr.tbl))
dev <- show.pr(mr.tbl, col="green", type="b")
dev <- show.pr(ar.tbl, device=dev, col="blue", type="b")
show.pr(clr.tbl, device=dev, col="red",type="b")
auc.pr(clr.tbl)
}
\keyword{misc}

