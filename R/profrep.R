#' Perform profile repeatability on a data-frame
#' 
#'
#' @param df The data frame Column 1 is the animal, column 2 is the time, the rest are the data
#' @param n_trials The number of rows an individual animal will have.
#' 
#' @returns Does not return any object, but prints out the summary of the 
#' profile repeatability measure for the data. TODO: Change this to return
#' a dataframe.
#'  
#' @export
profrep <- function(df, n_trials) {
  message("Welcome to profrep!")
  n_cols <- ncol(df)  # Number of columns in whole data frame
  message("Number of columns in input dataframe: ", n_cols)

  n_individuals = nrow(df) / n_trials  # Number of individual animals
  message("Number of individuals: ", n_individuals)
  
  n_replicates <- n_cols - 2  # Number of replicates (because of how the df is defined)
  message("Number of replicates: ", n_replicates)
  
  ids <- unique(df[, 1]) # the unique set of animal names
  
  # Now we get a list, where each element is a df of just that animal
  message("Separating dataframe into frames for individual animals.")
  individuals <- list()
  for (i in 1:length(ids)) {
    individuals[[i]] <- df[df[, 1] == ids[i], ]
  }
  
  # We now pass the list through the do_ordering function
  do_ordering(n_trials=n_trials, id_list=ids, df_list=individuals, n_replicates=n_replicates)
}