#' Compute the profile repeatability score for each groups of data
#' 
#' Splits the data into the data frame for a particular individual from 
#' the id_list, then calculates metrics to compute the profile repeatability 
#' score. Returns a data frame with the individuals name and the score.
#' 
#' @param id_list The list of the names of the individuals
#' @param df_list A list of data frames, each of which correspond to one of the names in the individual list
#' @param n_replicates The number of replicate columns (number of columns in a df in df_list)
#' @param n_trials The number of trials per individual (number of rows in a df in df_list) 
#'
#' @return A dataframe of two columns, where the first column is the individual name and the second is the profile repeatability score for the individual's data frame
#' 
#' @export
score_dfs <- function(id_list, df_list, n_replicates, n_trials) {
  max_variances_list <- c()
  scores <- c()
  crossings <- c()
  ave_variances <- c()
  # Compute balancing factor (max_vars), then compute scores
  for (i in 1:length(id_list)) {
    individual_name <- id_list[[i]]
    individual_df <- df_list[[i]]

    pair <- get_vars(individual_array=individual_df, n_replicates=n_replicates)
    variance_set <- pair$variances
    sum_of_values <- pair$total_sum
    ssq <- pair$ssq
    num_measurements <- pair$num_measurements
    
    sd <- sqrt(ssq / (num_measurements - 1) - num_measurements * (sum_of_values / num_measurements)**2 / (num_measurements - 1))
    max_variance <- max(variance_set)
    
    max_variances_list <- c(max_variances_list, max_variance)
    ave_variances <- c(ave_variances, 1.0*sum(variance_set)/length(variance_set))
    individual_score_list <- score_individual_df(individual_df, n_trials, n_replicates, max_variance = max_variance, variance_set = variance_set)
    crossings <- c(crossings, individual_score_list$n_crossings)
    scores <- c(scores, individual_score_list$base_score)
  }
  final_scores <- 1 - sigmoid(scores/100 - 5)
  df <- data.frame(
    individual=id_list, 
    n_crossings=crossings, 
    max_variance=round(max_variances_list,2),
    ave_variance=round(ave_variances, 2),
    base_score=round(scores, 2), 
    final_score=round(final_scores, 4)
  )
  return(df)
}