% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/functiesJT.R
\name{df_to_named_list}
\alias{df_to_named_list}
\title{Create a named list}
\usage{
df_to_named_list(df, items = 1, names = 2)
}
\arguments{
\item{df}{A dataframe}

\item{items}{A string or index number which indicates the column with the items for the named list}

\item{names}{A string or index number which indicates the column with the names for the named list}
}
\value{
Returns a named list
}
\description{
This function creates a named list from two dataframe columns
}
\details{
Deprecated use \code{tibble::deframe()} instead
}
