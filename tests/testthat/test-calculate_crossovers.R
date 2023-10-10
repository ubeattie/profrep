test_that("calculating crossovers works", {
  observed_data <- matrix(
     c(
       1, 60, 1, 2, 3, 4, 5,   # No NA values
       1, 90, 9, NA, 4, NA, 2,  # NA Values in row
       1, 120, 3, 6, NA, NA, 9  # Consecutive NA values
      ),
      nrow = 3,
      byrow=TRUE
   )
  expect_equal(calculate_crossovers(observed_data, 3, 5), 20)
})
