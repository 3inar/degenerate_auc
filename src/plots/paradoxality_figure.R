library(ProjectTemplate)
load.project()

png(file="figures/paradoxality.png", width=800)
plot(paradox_results, bty="n", type="o", pch=18, col="grey25", xlab="paradoxality",
     ylab="fraction AUC < .5")
dev.off()
