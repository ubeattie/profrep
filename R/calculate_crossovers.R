#' Calculate the Number of Crossovers in a Dataset
#'
#' This function calculates the number of crossovers in a dataset by comparing
#' the values of replicates across multiple trials. It assumes that missing
#' values (NAs) have been interpolated using the `clean_data` function.
#'
#' @param individual_df A data frame containing the individual dataset.
#' @param n_trials The total number of trials in the dataset (the number of rows)
#' @param n_replicates The total number of replicates in each trial (the number of columns - 2)
#'
#' @return The number of crossovers detected in the dataset.
#'
#' @seealso \code{\link{clean_data}} for information on data cleaning.
#'
#' @examples
#' # Example usage:
#' data <- matrix(
#'    c(
#'      1, 60, 1, 2, 3, 4, 5,   # No NA values
#'      1, 90, 9, NA, 4, NA, 2,  # NA Values in row
#'      1, 120, 3, 6, NA, NA, 9  # Consecutive NA values
#'     ),
#'     nrow = 3,
#'     byrow=TRUE
#' )
#' n_trials <- nrow(data)
#' n_replicates <- ncol(data) - 2
#' crossovers <- calculate_crossovers(data, n_trials, n_replicates)
#' cat("Number of crossovers:", crossovers, "\n")
#'
#' @export
calculate_crossovers <- function(individual_df, n_trials, n_replicates) {
  indicators <- c()
  clean_df <- clean_data(data=individual_df, n_trials=n_trials, n_replicates=n_replicates)
  for (t in 1:n_trials) {
    for (i in 1:(n_replicates - 1)) {
      val <- clean_df[t, i + 2]
      for (j in (i + 1):n_replicates) {
        nxt <- -1
        if (val >= clean_df[t, j + 2]) {
          nxt <- 1
        }
        indicators <- c(indicators, nxt)
      }
    }
  }
  n_pairs = n_replicates * (n_replicates - 1) / 2
  M <- matrix(indicators, n_pairs, n_trials)
  n_crossings <- 0
  for (t in 1:(n_trials-1)) {
    for (i in 1:n_pairs) {
      if (M[i,t] * M[i, t+1] == -1) {
        n_crossings <- n_crossings + 1
      }
    }
  }
  return(n_crossings)
}
