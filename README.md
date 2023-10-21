
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
[GitHub](https://github.com/) using
[devtools](https://devtools.r-lib.org) with:

``` r
# install.packages("devtools")
devtools::install_github("ubeattie/profrep")
```

You can install the stable version of profrep from
[CRAN](https://cran.r-project.org) with:

``` r
install.packages("profrep")
```

Alternatively, if one is using the [use_this](https://usethis.r-lib.org)
package, profrep can be installed with:

``` r
usethis::use_package("profrep")
```

## Example

The most common use pattern for profrep is to load in your data as a
data frame to the active session, and pass it to the main `profrep`
function. Below, we load in an example data set provided with the
profrep package:

``` r
library(profrep)

my_data <- profrep::synthetic_data_four_point
n_trials <- 4  # or however many trials/rows of data per individual exist 
profrep::profrep(df=my_data, n_trials=n_trials)
#>    individual n_crossings max_variance ave_variance base_score final_score rank
#> 1           E           0         6.67         5.42      12.10      0.9925    1
#> 2           B           0        15.00        12.92      27.95      0.9912    2
#> 3           D           0        26.67        26.40      53.12      0.9887    3
#> 4           F           0        58.92        56.59     115.62      0.9790    4
#> 5           G           0        91.67        87.42     179.27      0.9611    5
#> 6           I           0       106.67       106.67     213.55      0.9461    6
#> 7           J           5       106.67       106.67     277.33      0.9026    7
#> 8           C           0       207.58        86.81     294.81      0.8861    8
#> 9           K          15       106.67       106.67     384.00      0.7613    9
#> 10          H           0       375.00       149.42     525.17      0.4374   10
#> 11          A           0       456.25       181.88     639.04      0.1993   11
```

## License

[MIT License](https://opensource.org/license/mit/)

### Citing This Work

If you use `profrep` in your own published work, we ask that you include
a reference both to the original paper describing the method (Reed et
al., 2019) and the paper introducing this package (Beattie et al., in
prep.)

## Citations

1.  Baugh AT, Oers K van, Dingemanse NJ, Hau M. Baseline and
    stress-induced glucocorticoid concentrations are not repeatable but
    covary within individual great tits (Parus major). Gen Comp
    Endocrinol \[Internet\]. 2014;208:154–63. Available from:
    <http://dx.doi.org/10.1016/j.ygcen.2014.08.014>
2.  Beattie, U.K., Harris, D.R., Reed, J.M., Weaver, Z.R., Romero, L.M.
    in preparation
3.  Dingemanse NJ, Dochtermann NA. Quantifying individual variation in
    behaviour: Mixed-effect modelling approaches. J Anim Ecol.
    2013;82:39–54.
4.  Reed JM, Harris DR, Romero LM. Profile repeatability: A new method
    for evaluating repeatability of individual hormone response
    profiles. Gen Comp Endocrinol. 2019;270:1–9.
