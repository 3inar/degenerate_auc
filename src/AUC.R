library('ROCR')

lab <- c(rep(1,22),rep(0,66))



#RANDOM GUESS    -> answer is median at .5

n<- 150
aucs <- c()



for (i in 1:n){

  cvclasses <- sample(c(rep(1,18),rep(2,18),rep(3,18),rep(4,17),rep(5,17)),length(lab),replace=TRUE)   
  
  
  discard <- FALSE
  cvauc <- c()
  for (j in 1:5){
    #cvprob <- mean(lab[cvclasses!=j])     #frequence of A in the learning set
    cvprob <- .5
    
    if (sum(lab[cvclasses==j])==0){
      discard  <- TRUE
    }
    else {
      predictions <- rbinom(sum(cvclasses==j),1,cvprob)    #prediction in the test set
      #print(c("predictions",predictions))
      #print(c("lab",lab[cvclasses==j]))
      pred <- prediction(predictions,lab[cvclasses==j])
    }
    
    if (!discard){
       cvauc <- c(performance(pred,'auc')@y.values[[1]],cvauc)
    }
  }  
  
  aucs <- c(aucs,mean(cvauc))
    
}





#CAN STRATIFICATION BE THE REASON?


stratas <- rbinom(length(lab),1,.4)   #clinical with proba .4, screening with .6
X <- lab + stratas  + rnorm(length(lab),0,2+2*lab)

data <- as.data.frame(cbind(lab,stratas,X))

n <- 1500
aucs <- c()

for (i in 1:n){
  
  cvclasses <- sample(c(rep(1,18),rep(2,18),rep(3,18),rep(4,17),rep(5,17)),length(lab),replace=TRUE)   
  
  
  discard <- FALSE
  cvauc <- c()
  for (j in 1:5){
    #cvprob <- mean(lab[cvclasses!=j])     #frequence of A in the learning set
    cvprob <- .5
    
    if (sum(lab[cvclasses==j])==0){
      discard  <- TRUE
    }
    else {
      trainingdata <- as.data.frame(cbind(lab[cvclasses!=j],stratas[cvclasses!=j],X[cvclasses!=j]))
      colnames(trainingdata) <- c("lab","stratas","X")
      testdata <- as.data.frame(cbind(lab[cvclasses==j],stratas[cvclasses==j],X[cvclasses==j]))
      colnames(testdata) <- c("lab","stratas","X")
      model <- glm(lab~X,data=trainingdata,family=binomial()) 
      predictions <- predict.glm(model,newdata=testdata,type="response")    #prediction in the test set
      #print(c("predictions",predictions))
      #print(c("lab",lab[cvclasses==j]))
      pred <- prediction(predictions,lab[cvclasses==j])
    }
    
    if (!discard){
      cvauc <- c(performance(pred,'auc')@y.values[[1]],cvauc)
    }
  }  
  
  aucs <- c(aucs,mean(cvauc))
  
}

median(aucs[!is.na(aucs)])

#some of the datasets give median aucs <.5. One of them saved in strangedata.Rdata
