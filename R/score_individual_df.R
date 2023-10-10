#' Score an Individual Data Frame
#'
#' This function calculates a score for an individual data frame based on various factors,
#' including the number of crossovers, maximum variance, and a set of variances.
#'
#' @param individual_df A data frame containing individual data.
#' @param n_trials The total number of trials in the data frame.
#' @param n_replicates The total number of replicates in each trial.
#' @param max_variance The maximum allowed variance value.
#' @param variance_set A vector of variance values.
#'
#' @return A score calculated for the individual data frame.
#'
#' @details
#' The score is computed as follows:
#' - It factors in the number of crossovers using a scaling factor.
#' - It considers the maximum variance value in the variance set.
#' - It adds a component based on the average of variance values.
#' - It includes a scaled component of the number of crossovers.
#'
#' @seealso \code{\link{calculate_crossovers}} for information on crossovers calculation.
#'
#' @export
score_individual_df <- function(individual_df, n_trials, n_replicates, max_variance, variance_set) {
  # factor balances the contribution from number cross overs
  n_crossings <- calculate_crossovers(individual_df, n_trials, n_replicates)
  nx_of_ten <- round(0.01, 2)
  if (n_crossings > 0) {
    nx_of_ten <- round(20.0 * n_crossings / ((n_trials - 1) * n_replicates * (n_replicates - 1)), 0)
  }
  scale_factor <- max_variance / 5
  score <- max(variance_set) + 1.0 * sum(variance_set) / length(variance_set) + scale_factor * nx_of_ten
  return(score)
}