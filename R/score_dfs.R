#' @title Compute Profile Repeatability Score
#' 
#' @details
#' Works on multiple elements of data.
#' 
#' Splits the data into the data frame for a particular individual from 
#' the id_list, then calculates metrics to compute the profile repeatability 
#' score. Returns a data frame with the individuals name and the score.
#' 
#' @param id_list The list of the names of the individuals
#' @param df_list A list of data frames, each of which correspond to one of the names in the individual list
#' @param n_replicates The number of replicate columns (number of columns in a df in df_list)
#' @param n_trials The number of trials per individual (number of rows in a df in df_list) 
#' @param verbose A boolean parameter the defaults to FALSE. Determines whether messages are printed.
#'
#' @return A dataframe of the calculated metrics. The column structure is as follows:
#' 
#'          - Column 1: "individual" - the unique identifier of an individual or sample
#'          - Column 2: "n_crossings" - the calculated number of crossings.
#'          - Column 3: "max_variance" - the maximum of the variances of the replicate measurements at a single time for the individual or sample.
#'          - Column 4: "ave_variance" - the average of the variances of the replicate measurements at a single time for the individual or sample.
#'          - Column 5: "base_score" - the original, unnormalized profile repeatability score. Smaller numbers rank higher.
#'          - Column 6: "final_score" - the base score, normalized by the sigmoid function. Constrained to be between 0 and 1. Scores closer to 1 rank higher.
#'
#' @examples
#' df <- data.frame(
#'     col_a = c('A', 'A', 'B', 'B'),
#'     col_b = c(5, 15, 5, 15),
#'     col_c = c(5, 10, 1, 2),
#'     col_d = c(10, 15, 3, 4)
#'   )
#' id_list <- unique(df[, 1])
#' individuals <- list()
#' for (i in 1:length(id_list)) {
#'   individuals[[i]] <- df[df[, 1] == id_list[i], ]
#' }
#' ret_df <- score_dfs(id_list=id_list, df_list=individuals, n_replicates=2, n_trials=2)
#' print(ret_df)
#' 
#' @export
score_dfs <- function(id_list, df_list, n_replicates, n_trials, verbose=FALSE) {
  if (verbose) {message("Initializing empty vectors.")}
  max_variances_list <- c()
  scores <- c()
  crossings <- c()
  ave_variances <- c()
  # Compute balancing factor (max_vars), then compute scores
  if (verbose) {message("Computing score for each individual/sample.")}
  for (i in 1:length(id_list)) {
    individual_name <- id_list[[i]]
    individual_df <- df_list[[i]]

    if (verbose) {message("Calculating variances for individual: ", individual_name)}
    pair <- get_vars(individual_array=individual_df, n_replicates=n_replicates)
    
    # Unpack variance calculations
    variance_set <- pair$variances
    sum_of_values <- pair$total_sum
    ssq <- pair$ssq
    num_measurements <- pair$num_measurements
    
    # Calculate metrics
    sd <- sqrt(ssq / (num_measurements - 1) - num_measurements * (sum_of_values / num_measurements)**2 / (num_measurements - 1))
    max_variance <- max(variance_set)
    
    # Concatenate lists
    max_variances_list <- c(max_variances_list, max_variance)
    ave_variances <- c(ave_variances, 1.0*sum(variance_set)/length(variance_set))
    
    # Score the data
    individual_score_list <- score_individual_df(individual_df, n_trials, n_replicates, max_variance = max_variance, variance_set = variance_set)
    crossings <- c(crossings, individual_score_list$n_crossings)
    scores <- c(scores, individual_score_list$base_score)
  }
  if (verbose) {message("Variances and base scores calculated for all individuals. Calculating final scores.")}
  final_scores <- 1 - sigmoid(scores/100 - 5)
  
  # Create return dataframe
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