clean_data <- function(data, n_times, n_replicates) {
  missing_set <- c()
  
  for (t in 1:n_times) {
    for (i_rep in 1:n_replicates) {
      if (is.na(data[t, i_rep+2])) {
        n_missing <- length(missing_set) + 1
        missing_set <- c(missing_set, t * (n_replicates - 1) + i_rep)
        
        interp_val <- find_next_good_datapoint(data, t, i_rep, n_replicates)
        replacement_val <- data[t, i_rep + 1] + interp_val / 2
        data[t, i_rep + 2] <- replacement_val
      } # end line 6
    } # end line 5
  } # end line 4
}

find_next_good_datapoint <- function(data, t, i_rep, n_replicates) {
  interp_val <- -999
  proceed <- TRUE
  
  if ((i_rep + 1) <= n_replicates) {
    for (k_rep in (i_rep + 1):n_replicates) {
      cat("k_rep =", k_rep, "\n")
      if (proceed) {
        nxt <- data[t, k_rep + 2]
        cat("nxt =", nxt, "\n")
        if (nchar(nxt) >= 1 & !is.na(nxt)) {
          proceed <- FALSE
          interp_val <- nxt
        }
      }
    }
  }
  if (interp_val == -999) {
    interp_val <- data[t, i_rep + 1]
  }
  return(interp_val)
} # end find_next_good_datapoint function

# clean_data <- function(data, n_times, n_replicates) {
#   n_missing <- 0
#   missing_set <- c()
#   for (t in 1:n_times) {
#     for (irep in 1:n_replicates) {
#       if (is.na(data[t, irep + 2])) {
#         # Find Next Good Datapoint
#         n_missing <- n_missing + 1 # update number missing
#         missing_set <- c(missing_set, t*(n_replicates -1) + irep)
#         use <- -999
#         proceed <- 1
#         if ((irep + 1) < n_replicates) {
#           for (krep in (irep + 1):n_replicates) { # look ahead
#             nxt <- data[t, krep+2]
#             if (proceed) {
#               if (nchar(nxt) > 1 & !is.na(nxt)) {
#                 proceed <- 0
#                 use <- nxt
#               }
#               else {
#                 missing_set <- c(missing_set, t*(n_replicates -1) + krep)
#                 n_missing <- n_missing + 1
#               }
#             }
#           }
#         }
#         if (use == -999) {use <- data[t, irep + 1] + use / 2}
#         replacement <- data[t, irep + 1] + use / 2
#         data[t, irep + 2] <- replacement
#       }
#     }
#   }
#   return(data)
# }