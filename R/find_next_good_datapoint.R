#' @title What Is the Next Non-Null Data Point?
#'
#' @details
#' Given a data row, an index, and the number of replicates (the number of elements in the row),
#'this function finds the next good data point in the row.
#'
#' A good data point is a non-missing value (not NA) with a non-empty string.
#'
#' @param data_row A numeric vector representing the data row.
#' @param index The index of the current data point.
#' @param n_replicates The total number of replicates (length of the row)
#'
#' @return The next good data point or -999 if none is found.
#'
#' @examples
#' data_row <- c(NA, 3, 2, NA, 5)
#' index <- 1
#' n_replicates <- 5
#' find_next_good_datapoint(data_row, index, n_replicates) # expect 3
#'
#' @export
find_next_good_datapoint <- function(data_row, index, n_replicates) {
  interp_val <- -999
  proceed <- TRUE

  if ((index + 1) < n_replicates) {
    for (k in (index+1):n_replicates) {
      if (proceed) {
        next_val <- data_row[k]
        if (nchar(next_val) >= 1 & !is.na(next_val)) {
          proceed <- FALSE
          interp_val <- next_val
        }
      }
    }
  }
  
  if (interp_val == -999) {
    interp_val <- data_row[index - 1]
  }
  return(interp_val)
}