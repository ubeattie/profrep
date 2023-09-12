#' Perform profile repeatability on a data-frame
#' 
#'
#' @param df The data file. Column 1 is the animal, column 2 is the time, the rest are the data
#' @param n_rows The number of rows an individual animal will have.
#' 
#' @returns Does not return any object, but prints out the summary of the 
#'  profile repeatability measure for the data. TODO: Change this to return
#'  a dataframe.
#'  
#'  @export
profrep <- function(df, n_trials) {
  n_cols <- ncol(df)  # Number of columns in whole data frame
  
  n_individuals = nrow(df) / n_trials  # Number of individual animals
  n_replicates <- n_cols - 2  # Number of replicates (because of how the df is defined)
  
  ids <- unique(df$Animal) # the unique set of animal names
  
  # Now we get a list, where each element is a df of just that animal
  individuals <- list()
  for (i in 1:length(ids)) {
    individuals[[i]] <- subset(df, Animal == ids[i])
  }
  
  # We now pass the list through the do_ordering function
  do_ordering(n_trials=n_trials, id_list=ids, df_list=individuals, n_replicates=n_replicates)
}