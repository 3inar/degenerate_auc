library(ProjectTemplate)
library(ggplot2)
library(ggthemes)

load.project()

data <- paradox_generator(10000)

plot1 <- ggplot(data, aes(x)) +
          geom_density(aes(group=response, color=response))  +
          theme_tufte() +
          scale_fill_brewer()

plot2 <- plot1 + facet_grid(stratum~.)

ggsave("figures/density_wo_stratum.pdf", plot1, width = 5, height=3)
ggsave("figures/density_with_stratum.pdf", plot2, width = 5, height=3)
