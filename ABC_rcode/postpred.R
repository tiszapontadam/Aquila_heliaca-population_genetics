
library(abc)
library(ggplot2)
library(reshape2)

###Posterior predictive distributions

#Importing .def data files of initial parameter values
setwd()
parms <- data.frame()  
for (i in 1:1000) {
  temp <- read.csv(paste0("final_", i, ".def"), dec=".", sep=" ")
  parms <- rbind(parms, temp)
}

#Importing summary statistics of the observed data set
setwd()
obs <- read.table()

#Importing summary statistics of the simulated data sets
setwd()
ref <- read.table()

#Selecting most likely scenario
ref_7 <- ref[ref$scenario == 7,]

#Estimating posterior parameter distributions

bounds = matrix(data = NA, nrow = 15, ncol = 2)

for(i in 1:nrow(bounds)) {
  bounds[i,1] = min(parms[[i]])
  bounds[i,2] = max(parms[[i]])
}

loc0.01 = abc(target = obs, param = parms, sumstat = ref_7[,-27], method = "loclinear",
              tol = 0.01, transf = "logit", logit.bounds = bounds) #1% = 10,000 datasets

loc0.001 = abc(target = obs, param = parms, sumstat = ref_7[,-27], method = "loclinear",
              tol = 0.001, transf = "logit", logit.bounds = bounds) #0.1% = 1000 datasets

nnet0.1 = abc(target = obs, param = parms, sumstat = ref_7[,-27], method = "neuralnet",
              tol = 0.1, transf = "logit", logit.bounds = bounds) #10% = 100,000 datasets

nnet0.05 = abc(target = obs, param = parms, sumstat = ref_7[,-27], method = "neuralnet",
               tol = 0.05, transf = "logit", logit.bounds = bounds) #5% = 50,000 datasets



###Posterior predictive simulation

#sampling from posterior distributions
predsim <- matrix(NA, 1000, 15)
colnames(predsim) <- colnames(parms)

for (i in 1:nrow(predsim)) {
  for (j in 1:ncol(predsim)) {
    predsim[i,j] <- sample(nnet0.1[["adj.values"]][,j], 1)
  }
}
predsim <- as.data.frame(predsim)
predsim$CBRAT <- predsim$BNCB / predsim$CB
predsim$MBRAT <- predsim$BNMAC / predsim$MAC
predsim$CBGRAT <- log(predsim$BNCB/predsim$CB)/predsim$TBN
predsim$MGRAT <- log(predsim$BNMAC/predsim$MAC)/predsim$TBN

setwd()
write.table(predsim, "predsim_parm.def", quote = FALSE, row.names = FALSE, col.names = TRUE)

#after completion of the ABC pipeline, import results

postpred_sum <- read.table()
colnames(postpred_sum) <- colnames(obs)

#finding which oberved values fall outside the simulated posterior ranges
postpred_range <- lapply(postpred_sum, range, na.rm = TRUE)

outside <- sapply(names(obs), function(x) {
  obs[[x]] < postpred_range[[x]][1] ||
    obs[[x]] > postpred_range[[x]][2]
})

sum(outside)
names(obs)[outside]

