test_that("do_ordering function works", {
  df <- data.frame(
        col_a = c('A', 'A', 'B', 'B'),
        col_b = c(5, 15, 5, 15),
        col_c = c(5, 10, 1, 2),
        col_d = c(10, 15, 3, 4)
      )
  id_list <- unique(df[, 1])
  individuals <- list()
  for (i in 1:length(id_list)) {
    individuals[[i]] <- df[df[, 1] == id_list[i], ]
  }
  observed_df <- do_ordering(n_trials=2, id_list=id_list, df_list=individuals, n_replicates=2)
  expected_df <- data.frame(
    individual=c("B", "A"),
    n_crossings=c(0,0),
    max_variance=c(2.0, 12.5),
    ave_variance=c(2.0, 12.5),
    base_score=c(4.00, 25.02),
    final_score=c(0.9930, 0.9914), 
    rank=c(1,2)
  )
  expect_equal(observed_df, expected_df)
})
