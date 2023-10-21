#' @title Calculate Group Variance
#' 
#' @details
#' For the given individual array, for all rows of times, computes the variance in values
#' over replicates.
#' 
#' Returns these variances, sum of all values (for all times and replicates),
#' sum of all these values squared, and the number of values.
#' 
#' @param individual_array The array of data for an individual
#' @param n_replicates The number of replicate groups
#' 
#' @returns A list, where the elements are:
#' 
#'          1. variances: A vector of the variances of the sample
#'          2. total_sum: The sum of all the measurements in the sample
#'          3. ssq: The sum of all the squares of the measurements in the sample
#'          4. num_measurements: The total number of measurements in the sample that are not null
#'          
#' @examples
#' arr <- data.frame(
#'   individual=c("a", "a"),
#'   time=c(5, 15),
#'   col_a=c(1, 2),
#'   col_b=c(2, 3)
#' )
#' variance_return <- get_vars(individual_array=arr, n_replicates=2)
#' print(variance_return)
#' 
#' @export
get_vars <- function(individual_array, n_replicates) {
  n_rows_data <- nrow(individual_array)  # The number of rows in the individual array
  variance_list <- numeric(length=n_rows_data)

  all_values <- c()
  
  for (j in 1:n_rows_data) {
    
    measurements_at_j <- c()
    
    measurements_at_j <- unlist(individual_array[j, 3:ncol(individual_array)])
    all_values <- c(all_values, measurements_at_j)
    
    number_measurements_at_j <- length(measurements_at_j)
    
    if (number_measurements_at_j > 1) { 
      variance_list[j] <- stats::var(measurements_at_j, na.rm=TRUE)
    }
    else { variance_list[j] <- 0}
  }
    
  return(
    list(
      variances=variance_list,
      total_sum=sum(all_values, na.rm=TRUE),
      ssq=sum(all_values**2, na.rm=TRUE),
      num_measurements=length(all_values)
    )
  )
}