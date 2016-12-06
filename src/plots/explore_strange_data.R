# TODO: clean this mess up.
library(ProjectTemplate)
load.project()

library(ggplot2)
library(plyr)

ggplot(strange, aes(x=x, colour=response, linetype=stratum,
              group=interaction(stratum, response))) +
  geom_density() + theme_classic()

GGally::ggpairs(strange, aes(colour=response, linetype=stratum)) + theme_classic()

B <- 1500

while (TRUE) {
  dat <- paradox_generator(88)
  res <- raply(500, fivefold(dat), .progress="text")

  med <- median(na.omit(res[, 1]))
  med_i <- median(na.omit(res[, 2]))
  if (med < 0.5) break
}
ggplot(dat, aes(x=x, colour=response, linetype=stratum,
              group=interaction(stratum, response))) +
  geom_density() + theme_classic()

pairs(strange, main="strange")
pairs(nonstrange, main="non-strange")
pairs(strange2, main="strange2")
pairs(nonstrange2, main="non-strange 2")

ggplot(strange, aes(x=x, colour=response, linetype=stratum,
                group=interaction(stratum, response))) +
  geom_density() + theme_classic() + labs(title="strange")
ggplot(nonstrange, aes(x=x, colour=response, linetype=stratum,
                    group=interaction(stratum, response))) +
  geom_density() + theme_classic() + labs(title="non-strange")
ggplot(strange2, aes(x=x, colour=response, linetype=stratum,
                    group=interaction(stratum, response))) +
  geom_density() + theme_classic() + labs(title="strange 2")
ggplot(nonstrange2, aes(x=x, colour=response, linetype=stratum,
                    group=interaction(stratum, response))) +
  geom_density() + theme_classic() + labs(title="non-strange 2")


ggplot(strange2, aes(y=x, x=interaction(stratum, response), colour=response, linetype=stratum)) +
  geom_boxplot() + theme_classic() + labs(title="strange 2")


ggplot(strange, aes(y=x, x=interaction(stratum, response), colour=response, linetype=stratum)) +
  geom_boxplot() + theme_classic() + labs(title="strange")
