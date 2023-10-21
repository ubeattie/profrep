#' @title Calculates the sigmoid function of the input
#'
#' @param float A float number
#'
#' @returns A float number which is the result of the sigmoid function
#' 
#' @examples
#' sigmoid(0)
#' sigmoid(2)
#' 
#' @export
sigmoid <- function(float) {
  return (1.0 / (1 + exp(-float)))
}