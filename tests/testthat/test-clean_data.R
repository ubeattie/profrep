test_that("clean_data cleans data correctly", {
  # Test case 1: 
  observed_data <- matrix(
    c(
      1, 60, 1, 2, 3, 4, 5,   # No NA values
      1, 90, 9, NA, 4, NA, 2,  # NA Values in row
      1, 120, 3, 6, NA, NA, 9  # Consecutive NA values
    ),
    nrow = 3,
    byrow=TRUE
  )
  expected_data <- matrix(
    c(
      1, 60, 1, 2, 3, 4, 5,
      1, 90, 9, 11, 4.0, 6, 2,
      1, 120, 3, 6.0, 10.5, 15.75, 9
    ),
    nrow=3,
    byrow=TRUE
  )
  expect_equal(clean_data(data=observed_data, n_trials=3, n_replicates=5), expected_data)
})