#' @title Perform Profile Repeatability
#' 
#' @details
#' Calculates the profile repeatability measure of the input data according to 
#' the method in Reed et al. (2019).
#' 
#' 
#' @param df The input data frame, of minimum shape 2x3. This can be read in 
#'           from a csv or another data frame stored in memory. It is assumed 
#'           that the data frame is of the following structure:
#'           Column 1 is the unique identifier of an individual animal or sample 
#'           Column 2 is the time of the sample
#'           Column 3-N are the columns of replicate data.
#' @param n_trials The number of rows an individual sample will have. For example,
#'                 if the replicates were collected for individual 1 at times 15
#'                 and 30, for replicates A and B, the data frame would look like:
#'                 
#'                 | id | time | A | B |
#'                 |:--:|:----:|:-:|:-:|
#'                 | 1  | 15 | 1 | 2 |
#'                 | 1  | 30 | 3 | 4 |
#'                 
#' @param verbose A boolean parameter the defaults to FALSE. Determines whether messages are printed.
#' 
#' @returns Returns a data frame of the results, in the following form:
#' 
#'          - Column 1: "individual" - the unique identifier of an individual or sample
#'          - Column 2: "n_crossings" - the calculated number of crossings.
#'          - Column 3: "max_variance" - the maximum of the variances of the replicate measurements at a single time for the individual or sample.
#'          - Column 4: "ave_variance" - the average of the variances of the replicate measurements at a single time for the individual or sample.
#'          - Column 5: "base_score" - the original, unnormalized profile repeatability score. Smaller numbers rank higher.
#'          - Column 6: "final_score" - the base score, normalized by the sigmoid function. Constrained to be between 0 and 1. Scores closer to 1 rank higher.
#'          - Column 7: "rank" - the calculated ranking of the individual or sample, against all other individuals or samples in the data set.
#' 
#' @seealso \code{\link{do_ordering}} for the main data processing function.
#' @seealso \code{\link{calculate_crossovers}} for how the number of crossings are calculated.
#' @seealso \code{\link{score_individual_df}} for how the score is calculated for an individual or sample.
#' @seealso \code{\link{clean_data}} for how missing replicate values are handled.
#' 
#' @examples
#' test_data <- profrep::example_two_point_data
#' results <- profrep::profrep(df=test_data, n_trials=2)
#' 
#' @export
profrep <- function(df, n_trials, verbose=FALSE) {
  if (verbose) {message("Welcome to profrep!")}
  n_cols <- ncol(df)  # Number of columns in whole data frame
  if (verbose) {message("Number of columns in input dataframe: ", n_cols)}

  n_individuals = nrow(df) / n_trials  # Number of individuals
  if (verbose) {message("Number of individuals: ", n_individuals)}
  
  n_replicates <- n_cols - 2  # Number of replicates (because of how the df is defined)
  if (verbose) {message("Number of replicates: ", n_replicates)}
  
  ids <- unique(df[, 1]) # the unique set of individual names
  
  # Now we get a list, where each element is a df of just that animal
  if (verbose) {message("Separating data frame into data frames for individuals.")}
  individuals <- list()
  for (i in 1:length(ids)) {
    individuals[[i]] <- df[df[, 1] == ids[i], ]
  }
  
  # Pass the list through the do_ordering function
  ordered_df <- do_ordering(
    n_trials=n_trials, 
    id_list=ids, 
    df_list=individuals, 
    n_replicates=n_replicates,
    verbose=verbose
  )
  return(ordered_df)
  if (verbose) {message("profrep calculation complete!")}
}