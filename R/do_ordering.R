#' Performs the ordering of input data by scoring each individual data frame.
#' 
#' The main function of the package, this will send each individuals data out 
#' for scoring. Then, when all scores are computed, it will order the result
#' data frame by score and assign a rank.
#' 
#' Ranks are assigned with ties allowed - if N individuals have a tie, their rank
#' is averaged. For example, if the max score is 100, and two individuals have 
#' that score, their rank is 1.5
#'
#' @param n_trials The number of trials per individual (number of rows per individual dataframe)
#' @param id_list The list of unique individual names
#' @param df_list the list of dataframe per unique individual
#' @param n_replicates The number of replicates for each individual
#' 
#' @return An ordered dataframe with three columns: 
#' 1. individual: The name of the individual
#' 2. score: The profile repeatability score for the individual
#' 3. rank: The rank of the score, with ties allowed.
#' 
#' @export
do_ordering <- function(n_trials, id_list, df_list, n_replicates) {
  # cat("ID\tXigns Of_10 Mean SD\tMaxvar\tAvervar\tBase\tScore\n")
  
  # Generate Scores
  message("Scoring each set of data per animal.")
  scores_df <- score_dfs(id_list=id_list, df_list=df_list, n_replicates=n_replicates, n_trials=n_trials)

  # Order Scores and Individuals
  message("Ordering by score.")
  ordered_df <- scores_df[order(scores_df$final_score, decreasing=TRUE), ]
  
  # need the minus to rank the highest score the highest
  # average will make ties be the same decimal value
  ordered_df$rank <- rank(-ordered_df$final_score, ties.method="average")
  rownames(ordered_df) <- NULL
  
  return(ordered_df)
}

