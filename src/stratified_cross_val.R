library(ProjectTemplate)
load.project()

################################################################################
#               Stratified cross-validation: does it help?
################################################################################
library(plyr)
library(tibble)

n_samples <- 440

nostrat <- raply(350, function() {
  dat <- paradox_generator(n_samples, paradoxality=1)
  res <- raply(500, fivefold(dat))

  median(na.omit(res[, 1]))
}, .progress = "text")

strat <- raply(350, function() {
  dat <- paradox_generator(n_samples, paradoxality=1)
  res <- raply(500, fivefold(dat, strata = dat$stratum))

  median(na.omit(res[, 1]))
}, .progress = "text")


full_strat <- raply(350, function() {
  dat <- paradox_generator(n_samples, paradoxality=1)
  fullstrat <- as.factor(paste(dat$stratum, dat$response))
  res <- raply(500, fivefold(dat, strata = fullstrat))

  median(na.omit(res[, 1]))
}, .progress = "text")
