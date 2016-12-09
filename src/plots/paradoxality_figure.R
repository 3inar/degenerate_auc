library(ProjectTemplate)
load.project()

dev(png, file="figures/paradoxality.png")
plot(paradox_results, bty="n", type="o", pch=18, col="grey25", xlab="paradoxality",
     ylab="fraction AUC < .5")
dev.off()
