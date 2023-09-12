#' Retrieve Indices of Non-Missing Data for a Specific Time Point
#'
#' This function retrieves the indices of non-missing data values at a specific
#' time point from an individual array.
#'
#' @param individual_array A data matrix or data frame representing individual
#'   data, where rows correspond to time points and columns correspond to
#'   replicates and variables.
#' @param t The time point for which you want to retrieve non-missing data
#'   indices.
#' @param n_replicates The number of replicates in the data matrix.
#'
#' @return A numeric vector containing the indices of non-missing data values
#'   at the specified time point \code{t}. If there are no non-missing values or
#'   only one non-missing value, \code{NULL} is returned.
#'
#' @examples
#' # Example usage:
#' individual_data <- matrix(c(NA, 2, NA, 4, 5, NA), nrow = 1)
#' retrieve_good_data(individual_data, t = 1, n_replicates = 3)
#'
#' @seealso
#' \code{\link{which}} function for finding the indices of non-missing values.
#'
#' @keywords data manipulation
#'
#' @export
retrieve_good_data <- function(individual_array, t, n_replicates) {
  use_set <- which(!is.na(individual_array[t, (3:(2+n_replicates))]))
  
  if (length(use_set) == 0) {return(NULL)}
  
  return(use_set)
}

