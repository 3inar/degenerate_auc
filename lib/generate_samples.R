# draw samples with 1/4 prob of "response", 2/5 prob of "stratum"
generate_samples <- function(n, response_t=.25, stratum_t=.4, equal_variance=T) {
  ev <- ifelse(equal_variance, 0, 1)
  response <- as.factor(rbinom(n, 1, response_t))
  stratum <- as.factor(rbinom(n, 1, response_t))
  stratas <- rbinom(length(lab),1,.4)   #clinical with proba .4, screening with .6
  x <- lab + stratas  + rnorm(n, 0, 2+2*lab*ev)

  tibble::tibble(response, stratum, x)
}
