# draw samples with 1/4 prob of "response", 2/5 prob of "stratum"
generate_samples <- function(n, response_t=.25, stratum_t=.4, equal_variance=T) {
  ev <- ifelse(equal_variance, 0, 1)
  response <- rbinom(n, 1, response_t)
  stratum <- rbinom(n, 1, response_t)
  x <- response + stratum  + rnorm(n, 0, 2+2*response*ev)

  response <- as.factor(response)
  stratum <- as.factor(stratum)
  tibble::tibble(response, stratum, x)
}
