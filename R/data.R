#' Example Data: Two Point Data
#' 
#' An example of data that one would perform profile repeatability on. 
#' Consists of 9 individual animals, with corticosterone data taken at 2 timepoints (n_trials = 2), baseline (time = 3) and stress-induced (time = 30).
#' Then, there are 28 replicate columns.
#' 
#' @format ## `example_two_point_data`
#' A dataframe with 10 rows and 30 columns:
#' \describe{
#'    \item{Animal}{The animal name/unique identifier}
#'    \item{Time}{The time of the measurement, in days.}
#'    \item{SD.DR}{The name of the replicate column.}
#' }
#' 
#' @source This data was extracted from Romero & Rich 2007 (Comp Biochem. Physiol. Part A Mol. Integr. Physiol. 147, 562-568. https://doi.org/10.1016/j.cbpa.2007.02.004)
"example_two_point_data"

#' Example Data: Sparrow Repeatability (3 Point Data)
#' 
#' An example of data that one would perform profile repeatability on.
#' Consists of 12 individual animals, with corticosterone data taken at 3 times (n_trials = 3), baseline (time = 0) and two stress-induced (time = 15 and 30).
#' Then, there are 10 replicate columns. This example also shows what happens
#' when there are null data records for some individuals.
#' 
#' @format ## `sparrow_repeatability_three_point`
#' A dataframe with 36 rows and 12 columns:
#' \describe{
#'    \item{Animal}{The animal name/unique identifier}
#'    \item{TIME}{The time of the measurement, in days}
#'    \item{LD.500}{The name of the replicate column}
#' }
#' 
#' @source This data was extracted from Rich & Romero 2001 (J. Comp. Physiol. Part B Biochem. Syst. Environ. Physiol. 171, 543-647. https://doi.org/10.1007/s003600100204)
"sparrow_repeatability_three_point"

#' Example Data: Synthetic 4-Point Data
#' 
#' An example of data that one would perform profile repeatability on.
#' The data is synthetic data created for testing purposes and is designed to span a range of perceived repeatability scores.
#' Consists of 11 individual animals, with data taken at 4 times (n_trials = 4), baseline (time = 0) and three stress-induced (time = 15, 30, and 45).
#' Then, there are four replicate columns. Replicate column names refer to 
#' sample tests performed on the animal.
#' 
#' @format ## `synthetic_data_four_point`
#' A dataframe with 44 rows and 6 columns:
#' \describe{
#'    \item{Animal}{The animal name/unique identifier}
#'    \item{TIME}{The time of the measurement (unit not important)}
#'    \item{A}{The (unimportant) name of a replicate column.}
#'    \item{B}{The (unimportant) name of a replicate column.}
#'    \item{C}{The (unimportant) name of a replicate column.}
#'    \item{D}{The (unimportant) name of a replicate column.}
#' }
#' 
#' @source Data created for testing purposes by Reed et al., 2019 (Gen. Comp. Endocrinol. 270, 1-9. https://doi.org/10.1016/j.ygcen.2018.09.015)
"synthetic_data_four_point"
