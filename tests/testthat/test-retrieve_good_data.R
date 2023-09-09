test_that("retrieve_good_data returns correct indices", {
  # Test case 1: Single Row, Non-missing values, n_replicates=3
  data1 <- matrix(c(NA, 2, NA, 4, 5, NA), nrow = 1)
  expect_equal(retrieve_good_data(data1, t = 1, n_replicates = 3), 2:3)
  
  # Test case 2: Single Row, all missing values, n_replicates=3
  data2 <- matrix(c(NA, NA, NA, NA, NA, NA), nrow = 1)
  expect_null(retrieve_good_data(data2, t = 1, n_replicates = 3))
  
  # Test case 3: Single Row, missing value since n_replicates=3 and value is before that
  data3 <- matrix(c(NA, 2, NA, NA, NA, NA), nrow = 1)
  expect_null(retrieve_good_data(data3, t = 1, n_replicates = 3))
  
  # Test case 4: Non-missing values at time point t=1 (multiple rows)
  data4 <- matrix(c(NA, 2, NA, 4, 5, NA, 6, NA, 8, 9, NA, NA), nrow = 2)
  expect_equal(retrieve_good_data(data4, t = 1, n_replicates = 3), c(1, 2, 3))
  
  # Test case 5: Non-missing values at time point t=3 (multiple rows)
  data5 <- matrix(c(NA, 2, NA, 4, 5, NA, 6, NA, 8, 9, NA, NA), nrow = 3)
  expect_equal(retrieve_good_data(data5, t = 3, n_replicates = 2), c(1))
})