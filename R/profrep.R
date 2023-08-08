#' Perform profile repeatability
#' 
#' `profrep()` performs the profile repeatability metric on the provided item
#'
#' @param items The data file
#' @param n_rows The number of rows
#' 
#' @returns Does not return any object, but prints out the summary of the 
#'  profile repeatability measure for the data. TODO: Change this to return
#'  a dataframe.
profrep <- function(items, n_rows) {
  n_cols <- ncol(items)
  
  n_individuals = nrow(items) / n_rows
  n_replicates <- n_cols - 2
  
  names = items$Animal # This is why "Animal" must be the name of the first col 
  ids <- unique(names)
  
  inividuals <- list()
  for (j in ids) {
    inividuals[[j]] <- subset(items, Animal == j)
  }
  
  do_ordering(n_rows, ids, individuals, n_replicates)
}