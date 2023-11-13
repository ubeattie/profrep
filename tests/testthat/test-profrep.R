test_that("profrep calculates correctly for given data examples", {
  expected_two_point <- data.frame(
    individual = c(6, 9, 7, 1, 4),
    n_crossings = c(117, 150, 160, 149, 180),
    max_variance = c(83.64, 97.23, 151.26, 182.41, 197.31),
    ave_variance = c(53.26, 57.33, 96.69, 100.01, 113.02),
    base_score = c(187.09, 232.34, 368.95, 428.34, 507.64),
    final_score = c(0.9581, 0.9356, 0.7876, 0.6719, 0.4809),
    rank = c(1, 2, 3, 4, 5)
  )
  observed_two_point <- profrep::profrep(df=profrep::example_two_point_data, n_timepoints=2)
  expect_equal(observed_two_point, expected_two_point)
  
  expected_three_point <- data.frame(
    individual = c(6, 12, 8, 3, 11, 1, 7, 10, 4, 2, 9, 5),
    n_crossings = c(61, 25, 48, 28, 46, 43, 38, 43, 44, 37, 45, 27),
    max_variance = c(62.10, 131.99, 117.95, 141.99, 127.27, 122.97, 165.92, 170.59, 202.37, 257.66, 323.95, 486.60),
    ave_variance = c(45.88, 79.62, 78.27, 91.16, 71.03, 89.16, 110.26, 106.99, 95.08, 103.00, 145.47, 181.77),
    base_score = c(194.92, 290.80, 314.16, 318.35, 325.57, 335.10, 408.91, 448.16, 499.82, 566.79, 793.38, 960.32),
    final_score = c(0.9548, 0.8901, 0.8651, 0.8601, 0.8512, 0.8388, 0.7132, 0.6268, 0.5004, 0.3390, 0.0505, 0.0099),
    rank = c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12)
  )
  observed_three_point <- profrep::profrep(df=profrep::sparrow_repeatability_three_point, n_timepoints=3)
  expect_equal(observed_three_point, expected_three_point)
})
