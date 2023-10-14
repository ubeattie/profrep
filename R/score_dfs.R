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
#' @examples
#' id_list <- c('A', 'B', 'C')
#' df_list <- c(
#'   matrix(c(1, 60, 1, 2, 3, 4, 5, 1, 90, 9, NA, 4, NA, 2, 1, 120, 3, 6, NA, NA, 9), nrow = 3, byrow=TRUE),
#'   matrix(c(1, 60, 5, 6, 7, 8, 9, 1, 90, 9, NA, 4, NA, 2, 1, 120, 3, 6, NA, NA, 9), nrow = 3, byrow=TRUE),
#'   matrix(c(1, 60, 11, 12, 13, 14, 15, 1, 90, 9, NA, 4, NA, 2, 1, 120, 3, 6, NA, NA, 9), nrow = 3, byrow=TRUE)
#'   )
#' ret_df <- score_dfs(id_list, df_list, n_replicates=5, n_trials=3)
#' 
#' @export
score_dfs <- function(id_list, df_list, n_replicates, n_trials) {
  max_variances_list <- c()
  scores <- c()
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
    
    individual_score <- score_individual_df(individual_df, n_trials, n_replicates, max_variance = max_variance, variance_set = max_variances_list)
    scores <- c(scores, individual_score)
  }
  df <- data.frame(individual=id_list, score=scores)
  return(df)
}