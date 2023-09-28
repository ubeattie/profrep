
<!-- README.md is generated from README.Rmd. Please edit that file -->

# profrep

<!-- badges: start -->

[![R-CMD-check](https://github.com/ubeattie/profrep/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/ubeattie/profrep/actions/workflows/R-CMD-check.yaml)
[![pkgdown](https://github.com/ubeattie/profrep/actions/workflows/pkgdown.yaml/badge.svg)](https://github.com/ubeattie/profrep/actions/workflows/pkgdown.yaml)
<!-- badges: end -->

The goal of profrep is to calculate individual profile repeatability
(Reed et al., 2019).

One of the most common measurements that stress physiologists take is
blood samples for corticosterone quantification during a stress
response. This typically includes a sample at baseline (\<3 minutes of
stressor onset), one or more stress-induced samples (e.g. 30 minutes
after stressor onset), and potentially a negative feedback sample
(e.g. 120 minutes after stressor onset and/or after dexamethasone
injection). Such time series are called “stress response curves” and may
be taken multiple times in one individual. If researchers have multiple
stress response curves for an individual, they may want to quantify
repeatability to investigate, for example, heritibility. The current
standard in the field is to use linear mixed-effect models (Baugh et
al. 2014; Dingemanse and Dochtermann, 2013), however this type of
repeatability estimate can only be done on populations and on only one
timepoint at a time. Reed et al. (2019) have proposed “Profile
Repeatability,” which uses the full stress response curve (across time)
to estimate repeatability for individuals.

‘profrep’ is a R package for computing profile repeatability on any
number of individuals, any number of timepoints, and any number of
replicate stress resposne curves. A full explanation of the math behind
Profile Repeatability can be found in Reed et al. (2019).

## Installation

You can install the development version of profrep from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("ubeattie/profrep")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(profrep)
## basic example code
```

What is special about using `README.Rmd` instead of just `README.md`?
You can include R chunks like so:

``` r
summary(cars)
#>      speed           dist       
#>  Min.   : 4.0   Min.   :  2.00  
#>  1st Qu.:12.0   1st Qu.: 26.00  
#>  Median :15.0   Median : 36.00  
#>  Mean   :15.4   Mean   : 42.98  
#>  3rd Qu.:19.0   3rd Qu.: 56.00  
#>  Max.   :25.0   Max.   :120.00
```

You’ll still need to render `README.Rmd` regularly, to keep `README.md`
up-to-date. `devtools::build_readme()` is handy for this.

You can also embed plots, for example:

<img src="man/figures/README-pressure-1.png" width="100%" />

In that case, don’t forget to commit and push the resulting figure
files, so they display on GitHub and CRAN.

## Citations

1.  Baugh AT, Oers K van, Dingemanse NJ, Hau M. Baseline and
    stress-induced glucocorticoid concentrations are not repeatable but
    covary within individual great tits (Parus major). Gen Comp
    Endocrinol \[Internet\]. 2014;208:154–63. Available from:
    <http://dx.doi.org/10.1016/j.ygcen.2014.08.014>
2.  Dingemanse NJ, Dochtermann NA. Quantifying individual variation in
    behaviour: Mixed-effect modelling approaches. J Anim Ecol.
    2013;82:39–54.
3.  Reed JM, Harris DR, Romero LM. Profile repeatability: A new method
    for evaluating repeatability of individual hormone response
    profiles. Gen Comp Endocrinol. 2019;270:1–9.
