#' Calculates the sigmoid function of the input
#'
#' @param float A float number
#'
#' @returns A float number which is the result of the sigmoid function
#' @export
#' 
#' @examples
#' sigmoid(0)
#' sigmoid(2)
#' 
sigmoid <- function(float) {
  return (1.0 / (1 + exp(-float)))
}