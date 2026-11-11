
library(abc)

#Importing summary statistics of the observed data set
setwd()
obs <- read.table()

#Importing summary statistics of the simulated data sets
setwd()
ref <- read.table()

#Model (scenario) selection

#MNLOGISTIC
#1% = 100,000 datasets accepted
mnlog0.01 = postpr(index = ref[,27], sumstat = ref[,-27], 
                   target = obs, method = "mnlogistic", tol = 0.01)
barplot(mnlog0.01[["pred"]])
summary(mnlog0.01)

#0.1% = 10,000 datasets accepted
mnlog0.001 = postpr(index = ref[,27], sumstat = ref[,-27], 
                    target = obs, method = "mnlogistic", tol = 0.001)
barplot(mnlog0.001[["pred"]])
summary(mnlog0.001)

#0.01% = 1000 datasets accepted
mnlog0.0001 = postpr(index = ref[,27], sumstat = ref[,-27], 
                     target = obs, method = "mnlogistic", tol = 0.0001)
barplot(mnlog0.0001[["pred"]])
summary(mnlog0.0001)


#NEURAL NET
#5% neural net 500,000 datasets
nnet0.05 = postpr(index = ref[,27], sumstat = ref[,-27],
                  target = obs, method = "neuralnet", tol = 0.05)
barplot(nnet0.05[["pred"]])
summary(nnet0.05)

#1% neural net 100,000 datasets
nnet0.01 = postpr(index = ref[,27], sumstat = ref[,-27],
                  target = obs, method = "neuralnet", tol = 0.01)
barplot(nnet0.01[["pred"]])
summary(nnet0.01)

#0.5% neural net 50,000 datasets
nnet0.005= postpr(index = ref[,27], sumstat = ref[,-27],
                  target = obs, method = "neuralnet", tol = 0.005)
barplot(nnet0.005[["pred"]])
summary(nnet0.005)



#Cross validation
mncv0.001 = cv4postpr(index = ref[,19], sumstat = ref[,-19],
                      method = "mnlogistic", tols = 0.1, nval = 1)

nnetcv0.01 = cv4postpr(index = ref[,27], sumstat = ref[,-27],
                      method = "neuralnet", tol = 0.01, nval = 100)

summary(mncv0.001)
summary(nnetcv0.01)
plot(mncv0.001)
plot(nnetcv0.01)

