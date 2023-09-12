# test_that("find_next_good_datapoint returns correct values", {
#   # Test case 1: 1 row, NA in middle of column
#   data1 <- matrix(
#     c(NA, 2, NA, 6, NA),
#     nrow = 1,
#     byrow=TRUE,
#   )
#   expect_equal(find_next_good_datapoint(data1, t = 1, i_rep = 1, n_replicates = 3), 2)
#   expect_equal(find_next_good_datapoint(data1, t = 1, i_rep = 2, n_replicates = 3), 6)
#   expect_equal(find_next_good_datapoint(data1, t = 1, i_rep = 3, n_replicates = 3), 6)
#   
  # # Test case 2: Multiple rows with NA values
  # data2 <- matrix(
  #   c(
  #     NA, 2, 3, NA, 5,
  #     6, NA, NA, 9, 10
  #   ),
  #   nrow = 2,
  #   byrow=TRUE
  # )
  # expect_equal(find_next_good_datapoint(data2, t = 1, i_rep = 1, n_replicates = 3), 5)
  # expect_equal(find_next_good_datapoint(data2, t = 2, i_rep = 1, n_replicates = 3), 9)
  # expect_equal(find_next_good_datapoint(data2, t = 2, i_rep = 1, n_replicates = 4), 10)
  
# })