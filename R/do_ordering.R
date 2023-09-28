#' Performs the ordering of input data by scoring each individual data frame.
#'
#' @param n_trials The number of trials per individual (number of rows per individual dataframe)
#' @param id_list The list of unique individual names
#' @param df_list the list of dataframe per unique individual
#' @param n_replicates The number of replicates for each individual
#' 
#' @export
do_ordering <- function(n_trials, id_list, df_list, n_replicates) {
  # cat("ID\tXigns Of_10 Mean SD\tMaxvar\tAvervar\tBase\tScore\n")
  
  # Generate Scores
  message("Scoring each set of data per animal.")
  original_scores <- score_dfs(id_list=id_list, df_list=df_list, n_replicates=n_replicates, n_trials=n_trials)

  # Order Scores and Individuals
  message("Ordering by score.")
  order <- c()
  for (x in sort(original_scores)) {
    nxt <- 0
    for (id in id_list) {
      nxt <- nxt + 1
      if (x == original_scores[nxt]) {
        order <- c(order, id)
      }
    }
  }

  # Print Results
  cat(c("Final Rank Order (by individual name)\n"))
  cat(c(order, "\n"))
  cat(c("____________\n"))
  
}

