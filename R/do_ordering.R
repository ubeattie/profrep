#'
#'
#' @param n_trials The number of trials per individual (number of rows per individual dataframe)
#' @param id_list The list of unique individual names
#' @param df_list the list of dataframe per unique individual
#' @param n_replicates The number of replicates for each individual
#' 
#' @export
do_ordering <- function(n_trials, id_list, df_list, n_replicates) {
  cat("ID\tXigns Of_10 Mean SD\tMaxvar\tAvervar\tBase\tScore\n")
  
  # Generate Scores
  scores <- score_dfs(id_list=id_list, df_list=df_list, n_replicates=n_replicates)
  n_trial <- n_trials
  n_replicate <- n_replicates
  # Order Scores and Individuals
  
  # Print Results
  
}

