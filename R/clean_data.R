#' Clean Data by Interpolating Missing Values
#'
#' This function cleans a dataset by interpolating missing values in the replicate
#' columns of each row using neighboring values. If the data frame ends in null values
#' (the last columns are nulls), it will truncate to not include those columns.
#'
#' @param data A data frame containing the dataset to be cleaned.
#' @param n_trials The total number of rows in the dataset.
#' @param n_replicates The total number of replicate columns in each row.
#'
#' @return A cleaned data frame with missing values interpolated.
#'
#' @seealso \code{\link{find_next_good_datapoint}} for details on the interpolation process.
#'
#' @examples
#' # Example usage:
#' my_data <- matrix(
#'    c(
#'      1, 60, 1, 2, 3, 4, 5,   # No NA values
#'      1, 90, 9, NA, 4, NA, 2,  # NA Values in row
#'      1, 120, 3, 6, NA, NA, 9  # Consecutive NA values
#'     ),
#'     nrow = 3,
#'     byrow=TRUE
#'  )
#' cleaned_data <- clean_data(my_data, n_trials = 3, n_replicates = 5)
#'
#' @export
clean_data <- function(data, n_trials, n_replicates) {
  missing_set <- c()
  
  for (t in 1:n_trials) { # loops through rows
    trial_row <- data[t, 3:ncol(data)] # get the row of replicate data only
    
    for (i_rep in 1:n_replicates) { # loops through replicate columns
      # replicate columns are really index 3 to the end of the data frame
      if (is.na(trial_row[i_rep])) {
        n_missing <- length(missing_set) + 1 # increase number missing 
        missing_set <- c(missing_set, t*(n_replicates -1) + i_rep) # add to missing set
        
        interp_val <- find_next_good_datapoint(trial_row, i_rep, n_replicates)
        # If the first value is null, need to pull the last replicate value.
        if (i_rep == 1) {first_val = trial_row[n_replicates]}
        else {first_val = trial_row[i_rep - 1]}
        
        replacement_val <- first_val + interp_val / 2 
        trial_row[i_rep] <- replacement_val
      }
    }
    data[t, 3:ncol(data)] <- trial_row
  }
  return(data)
}