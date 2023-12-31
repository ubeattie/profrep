% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/do_ordering.R
\name{do_ordering}
\alias{do_ordering}
\title{Score and Order Data}
\usage{
do_ordering(
  n_trials,
  id_list,
  df_list,
  n_replicates,
  verbose = FALSE,
  sort = TRUE
)
}
\arguments{
\item{n_trials}{The number of rows an individual sample will have.}

\item{id_list}{The list of unique individual or sample names}

\item{df_list}{The list of data frames per unique individual}

\item{n_replicates}{The number of replicates in the study.}

\item{verbose}{A boolean parameter the defaults to FALSE. Determines whether messages are printed.}

\item{sort}{A boolean parameter that defaults to TRUE. If TRUE, sorts the returned data frame by score. If FALSE, returns the data in the individual order it was provided in}
}
\value{
Returns a data frame of the results, in the following form:

\if{html}{\out{<div class="sourceCode">}}\preformatted{     - Column 1: "individual" - the unique identifier of an individual or sample
     - Column 2: "n_crossings" - the calculated number of crossings.
     - Column 3: "max_variance" - the maximum of the variances of the replicate measurements at a single time for the individual or sample.
     - Column 4: "ave_variance" - the average of the variances of the replicate measurements at a single time for the individual or sample.
     - Column 5: "base_score" - the original, unnormalized profile repeatability score. Smaller numbers rank higher.
     - Column 6: "final_score" - the base score, normalized by the sigmoid function. Constrained to be between 0 and 1. Scores closer to 1 rank higher.
     - Column 7: "rank" - the calculated ranking of the individual or sample, against all other individuals or samples in the data set.
}\if{html}{\out{</div>}}
}
\description{
Score and Order Data
}
\details{
Performs the ordering of input data by scoring each individual data frame.

The main function of the package, this will send each individuals data out
for scoring. Then, when all scores are computed, it will order the result
data frame by score and assign a rank.

Ranks are assigned with ties allowed - if N individuals have a tie, their rank
is averaged. For example, if the max score is 1, and two individuals have
that score, their rank is 1.5
}
\examples{
df <- data.frame(
    col_a = c('A', 'A', 'B', 'B'),
    col_b = c(5, 15, 5, 15),
    col_c = c(5, 10, 1, 2),
    col_d = c(10, 15, 3, 4)
  )
id_list <- unique(df[, 1])
individuals <- list()
for (i in 1:length(id_list)) {
  individuals[[i]] <- df[df[, 1] == id_list[i], ]
}
ret_df <- do_ordering(n_trials=2, id_list=id_list, df_list=individuals, n_replicates=2)
print(ret_df)

}
