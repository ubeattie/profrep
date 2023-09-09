#' Calculates the variances of the groups
#' 
#' For the given individual i, for a given time, computes the variance in values
#' over replicates.
#' 
#' Returns these variances, sum of all values (for all times and replicates),
#' sum of all these values squared, and the number of values.
#' 
#' Change: instead of passing in i, individuals -> let's do individual
#' Then whatever calls this function should do individuals at i
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
#' @export
get_vars <- function(individual_array, n_replicates) {
  n_rows_data <- nrow(individual_array)  # The number of rows in the individual array
  variance_list <- numeric(n_rows_data)
  # lens <- numeric(n_rows_data)
  
  all_values <- c()
  
  for (j in 1:n_rows_data) {
    measurements_at_j <- c()
    
    # Loop through data, calculate the values
    for (k in 3:(2 + n_replicates)) {
      measurement <- individual_array[j, k]
      if (!is.na(measurement)) {
        measurements_at_j <- c(measurements_at_j, measurement)
        all_values <- c(all_values, measurement)
      }
    }
    
    number_measurements_at_j <- length(measurements_at_j)
    # lens[j] <- number_measurements_at_j
    
    if (number_measurements_at_j > 1) { 
      print(measurements_at_j)
      variance_list[j] <- stats::var(measurements_at_j)
    }
    else { variance_list[j] <- 0}
  }
  
  return(
    list(
      variances=variance_list,
      total_sum=sum(all_values),
      ssq=sum(all_values**2),
      num_measurements=length(all_values)
    )
  )
}