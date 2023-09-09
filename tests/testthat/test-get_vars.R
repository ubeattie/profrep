test_data <- matrix(
  c(
    NA, NA, 1, 2, 3, NA,
    4, 5, 6, 7, 8, 9,
    NA, NA, NA, NA, NA, NA
  ),
  nrow = 3,
  byrow=TRUE,
)

# Test cases
test_that("get_vars calculates variances and sums correctly", {
  result <- get_vars(test_data, n_replicates = 3)
  
  # Check if variances are calculated correctly
  # Because we are choosing 3 replicates, we expect it to pull the numbers
  # 1, 2, 3 from the first row and 6, 7, 8
  expect_equal(result$variances, c(var(c(1, 2, 3)), var(c(6, 7, 8)), 0))
  
  # Check if total sum is calculated correctly
  expect_equal(result$total_sum, sum(c(1, 2, 3, 6, 7, 8)))
  
  # Check if sum of squares (ssq) is calculated correctly
  expect_equal(result$ssq, sum(c(1, 2, 3, 6, 7, 8)^2))
  
  # Check if the number of measurements is calculated correctly
  expect_equal(result$num_measurements, 6)
})