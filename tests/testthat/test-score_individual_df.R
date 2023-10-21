test_that("test individual scoring algorithm works", {
  arr <- data.frame(
    individual=c("a", "a"),
    time=c(5, 15),
    col_a=c(1, 2),
    col_b=c(2, 3)
  )
  variance_set <- c(0.5, 0.5)
  max_variance <- 0.5
  observed_list <- score_individual_df(
    individual_df=arr,
    n_trials=2,
    n_replicates=2,
    max_variance=max_variance,
    variance_set=variance_set
  )
  expected_list <- list(n_crossings=0, base_score=1.001)
  expect_equal(observed_list, expected_list)
})
