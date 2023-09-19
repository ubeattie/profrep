# profrep
<!-- badges: start -->
  [![R-CMD-check](https://github.com/ubeattie/profrep/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/ubeattie/profrep/actions/workflows/R-CMD-check.yaml)
[![pkgdown](https://github.com/ubeattie/profrep/actions/workflows/pkgdown.yaml/badge.svg)](https://github.com/ubeattie/profrep/actions/workflows/pkgdown.yaml)
<!-- badges: end -->
  
This code is for the profrep R package to calculate individual profile repeatability (Reed et al., 2019) <!-- example: one-liner -->

One of the most common measurements that stress physiologists take is blood samples for corticosterone quantification during a stress response. This typically includes a sample at baseline (<3 minutes of stressor onset), one or more stress-induced samples (e.g. 30 minutes after stressor onset), and potentially a negative feedback sample (e.g. 120 minutes after stressor onset and/or after dexamethasone injection). Such time series are called "stres response curves" and may be taken multiple times in one individual. If researchers have multiple stress response curves for an individual, they may want to quantify repeatability to investigate, for example, heritibility. The current standard in the field is to use linear mixed-effect models (Baugh et al. 2014; Dingemanse and Dochtermann, 2013), however this type of repeatability estimate can only be done on populations and on only one timepoint at a time. Reed et al. (2019) have proposed "Profile Repeatability," which uses the full stress response curve (across time) to estimate repeatability for individuals. 'profrep' is a R package for computing profile repeatability on any number of individuals, any number of timepoints, and any number of replicate stress resposne curves. A full explanation of the math behind Profile Repeatability can be found in Reed et al. (2019).


Things to include in the readme:
- one liner explaining the purpose of the package - done
- short description of the goals of the package (1-2 paragraphs) - done
- theory: a 2-4 paragraph description of the theory behind the code (purpose, math, etc)

## Package Goals

<!-- put the short description here -->

## Theory

<!-- put the theory here -->

## Citations

<!-- put any citations in the theory here -->
Baugh AT, Oers K van, Dingemanse NJ, Hau M. Baseline and stress-induced glucocorticoid concentrations are not repeatable but covary within individual great tits (Parus major). Gen Comp Endocrinol [Internet]. 2014;208:154–63. Available from: http://dx.doi.org/10.1016/j.ygcen.2014.08.014

Dingemanse NJ, Dochtermann NA. Quantifying individual variation in behaviour: Mixed-effect modelling approaches. J Anim Ecol. 2013;82:39–54. 

Reed JM, Harris DR, Romero LM. Profile repeatability: A new method for evaluating repeatability of individual hormone response profiles. Gen Comp Endocrinol. 2019;270:1–9. 

<!-- don't worry about what is below this line -->

## Demo

## Further Informtion

## Development

To run `R CMD check`: `devtools::check()`

To run test suite: `devtools::test()`

To run a single file of tests: `testthat::test_file("tests/testthat/<test_file_name>.R")

To update package documentation: `devtools::document()`

## Actions

This repo uses GitHub Actions to maintain the code base. There are actions to:

- Run the `R CMD check` on the three major operating systems for the current and former R version
- Build the project website with `pkgdown`
