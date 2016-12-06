library(ProjectTemplate)
load.project()

################################################################################
#               simulate from increasingly paradoxical model
################################################################################
library(plyr)
library(tibble)


paradox_degree <- seq(0,1,by=0.1)

rate <- aaply(paradox_degree, 1, function(paradoxality) {
  aucs <- raply(1000, function() {
    dat <- paradox_generator(88)
    res <- raply(500, fivefold(dat))

    median(na.omit(res[, 1]))
  })
  sum(aucs < 0.5)/length(aucs)
}, .progress="text")

paradox_results <- tibble(paradox_degree, rate)
save(paradox_results, file="data/paradox_results.rda")
