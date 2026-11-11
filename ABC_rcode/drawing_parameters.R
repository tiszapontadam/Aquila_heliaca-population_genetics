
library(KScorrect)

#Determining name of parameters and number of simulations
parnames = c("BNCB", "BNMAC",
              "CB", "MAC", "THAN", "EAST",
              "MIG",
              "TBN", "TDIV1", "TDIV2", "TDIV3",
              "CBRAT", "MBRAT", "CBGRAT", "MGRAT")
nsims = 1000000

#Generating parameters

#effective population sizes
CB = round(runif(nsims, 1800, 2000))
MAC = round(runif(nsims, 100, 140))
THAN = round(runif(nsims, 1500, 2000))
EAST = round(runif(nsims, 24000, 25000))

#migration rate
MIG = rlunif(nsims, 1e-4, 1e-3)

#effective population sizes after bottleneck
BNMAC = round(runif(nsims, 12, 40))
BNCB = round(runif(nsims, 60, 160))

#population divergence times
TDIV3 = round(runif(nsims, 11, 1111))
TBN = round(runif(nsims, 5, 11))
TDIV2 = c()
TDIV1 = c()

for(x in 1:nsims) {
  TDIV2[x] = round(runif(1, 11, TDIV3[x]))
  TDIV1[x] = round(runif(1, 11, TDIV2[x]))
}

#effective population size ratios for bottlenecks
CBRAT = BNCB/CB
MBRAT = BNMAC/MAC

#growth rates for bottlenecked populations
CBGRAT = log(BNCB/CB)/TBN
MGRAT = log(BNMAC/MAC)/TBN

#Saving parameters
parameters = data.frame(BNCB, BNMAC,
                    CB, MAC, THAN, EAST,
                    MIG,
                    TBN, TDIV1, TDIV2, TDIV3,
                    CBRAT, MBRAT, CBGRAT, MGRAT)
names(parameters) = parnames

setwd()

#iterations were processed in 1000 chunks of 1000 sets to elevate computational performance
for (i in 1:1000) {
  start_row <- (i - 1) * 1000 + 1
  end_row <- i * 1000

  chunk <- parameters[start_row:end_row, ]

  write.table(chunk, paste0("final", "_", i, ".def"), quote = FALSE, row.names = FALSE, col.names = TRUE)
}
