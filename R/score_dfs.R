score_dfs <- function(id_list, df_list, n_replicates) {
  max_variances_list <- c()
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
    
    # individual_score <- score_individual()
  }
  return(NA)
}