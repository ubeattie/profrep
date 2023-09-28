test_that("find_next_good_datapoint returns correct values", {
  # Test case 1: no NA
  data1 <- matrix(
    c(1, 5, 4, 6, 3),
    nrow = 1,
    byrow=TRUE,
  )
  expect_equal(find_next_good_datapoint(data_row=data1, index = 1, n_replicates = 5), 5)
  expect_equal(find_next_good_datapoint(data_row=data1, index = 2, n_replicates = 5), 4)
  expect_equal(find_next_good_datapoint(data_row=data1, index = 3, n_replicates = 5), 6)
  expect_equal(find_next_good_datapoint(data_row=data1, index = 4, n_replicates = 5), 3)
  
  # Test case 2: NAs in row - only test NA rows
  data2 <- matrix(
    c(1, NA, 4, NA, 3),
    nrow = 1, 
    byrow = TRUE,
  )
  expect_equal(find_next_good_datapoint(data_row = data2, index=2, n_replicates=5), 4)
  expect_equal(find_next_good_datapoint(data_row = data2, index=4, n_replicates=5), 3)
  
  # Test Case 3: Consecutive NA Values in the row
  data3 <- matrix(
    c(1, NA, 4, NA, NA, 3),
    nrow = 1,
    byrow=TRUE
  )
  expect_equal(find_next_good_datapoint(data_row = data3, index=1, n_replicates=6), 4)
  expect_equal(find_next_good_datapoint(data_row = data3, index=2, n_replicates=6), 4)
  expect_equal(find_next_good_datapoint(data_row = data3, index=3, n_replicates=6), 3)
  expect_equal(find_next_good_datapoint(data_row = data3, index=4, n_replicates=6), 3)
  expect_equal(find_next_good_datapoint(data_row = data3, index=5, n_replicates=6), 3)
})
