test_that("sigmoid function works and makes correct output", {
  expect_equal(sigmoid(0), 0.5)
  expect_equal(sigmoid(4), 0.9820138)
  expect_equal(sigmoid(1000), 1)
})

test_that("sigmoid function throws error if string", {
  expect_error(sigmoid("a"), "invalid argument")
})