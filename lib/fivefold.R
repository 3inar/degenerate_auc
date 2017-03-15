# fivefold cv
fivefold <- function(data, strata=1:nrow(data)) {
  nsamples <- nrow(data)
  nfolds <- 5

  folds <- caret::createFolds(strata, k=nfolds)

  estimates <- NULL
  for(i in 1:nfolds)
  {
    testindex <- folds[[i]]
    trainindex <- which(!1:nsamples %in% testindex)

    if (any(data[testindex, "response"] =="1")) {
      model <- glm(response~x, data=data, family = binomial, subset=trainindex)
      model_i <- glm(response~x*stratum, data=data, family = binomial, subset=trainindex)

      newx <- data[testindex, ]
      prediction <- predict(model, newdata=newx, type="response")
      prediction_i <- predict(model_i, newdata=newx, type="response")


      auc <- AUC::auc(AUC::roc(prediction, newx$response))
      auc_i <- AUC::auc(AUC::roc(prediction_i, newx$response))

      estimates <- rbind(estimates, c(auc, auc_i))
    } else {
      estimates <- rbind(estimates, c(NA, NA))
    }
  }

  colMeans(estimates)
}
