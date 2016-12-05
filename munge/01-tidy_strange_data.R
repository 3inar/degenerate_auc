load("data/strange.rda")
strange <- tibble::as_tibble(data)
rm(data)

colnames(strange) <- c("response", "stratum", "x")
strange <- dplyr::mutate(strange, response=as.factor(response))
strange <- dplyr::mutate(strange, stratum=as.factor(stratum))
