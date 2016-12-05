# degenerate_auc

Some time you can get AUC < .5 without there being something wrong with
your model or the way you calculated AUC. How?

## Notes

 - we suspect it's due to omitted variable (stratum indicator)
 - this is _not_ a high-dimensional problem, we can recreate (some times) with 
 about 90 samples and two predictors
 
## Ideas

 - Does it have something to do with the degree to which the stratum is
 predictive?
 - Does it have something to do with the stratum-response interaction?
