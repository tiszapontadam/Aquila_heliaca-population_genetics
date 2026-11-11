
library(adegenet)

#Import .str type files
setwd()
data <- read.table("", header = FALSE, sep = "")
data[data == -9] = NA

#Create admixture function
admix_coef <- function(hpop, popa, popb) {

pA_list <- list()
pB_list <- list()
x_list  <- list()

locus_index <- 1

#computing allele counts for hybrid pop and frequencies for parent pops 
for (i in seq(3, ncol(data), by = 2)) {
  
  alleles <- sort(unique(na.omit(unlist(data[, i:i+1]))))
    
    ph_pop <- data[data$V2 == hpop,]
    p1_pop <- data[data$V2 == popa,]
    p2_pop <- data[data$V2 == popb,]
    
    ph_alleles <- (unlist(ph_pop[, c(i,i+1)]))
    p1_alleles <- (unlist(p1_pop[, c(i,i+1)]))
    p2_alleles <- (unlist(p2_pop[, c(i,i+1)]))
    
    ph_all_rat <- prop.table(table(factor(ph_alleles, levels = alleles)))
    p1_all_rat <- prop.table(table(factor(p1_alleles, levels = alleles)))
    P2_all_rat <- prop.table(table(factor(p2_alleles, levels = alleles)))

#hybrid counts
x_counts <- table(factor(ph_alleles, levels = alleles))

#parental frequencies
p1_freq <- prop.table(table(factor(p1_alleles, levels = alleles)))
p2_freq <- prop.table(table(factor(p2_alleles, levels = alleles)))

#store as vectors
x_list[[locus_index]]  <- as.numeric(x_counts)
names(x_list[[locus_index]]) <- alleles

pA_list[[locus_index]] <- as.numeric(p1_freq)
names(pA_list[[locus_index]]) <- alleles

pB_list[[locus_index]] <- as.numeric(p2_freq)
names(pB_list[[locus_index]]) <- alleles

locus_index <- locus_index + 1

}

#multilocus likelihood fucntion
logLik_locus <- function(q, pA, pB, x) {
  
  pH <- q * pA + (1 - q) * pB

  pH <- pmax(pH, 1e-12)
  
  sum(x * log(pH))
}

negLogLik_total <- function(q) {
  
  total <- 0
  
  for (l in 1:length(pA_list)) {
    total <- total + logLik_locus(q,
                                  pA_list[[l]],
                                  pB_list[[l]],
                                  x_list[[l]])
  }
  
  return(-total)
}

result <- optimize(negLogLik_total, interval = c(0,1))

q_hat <- result$minimum
q_hat

}

#name all possible combinations accordingly, where 1=CB, 2=MAC, 3=THAN, 4=CENT

result_admix_coef <- as.data.frame(matrix(nrow = 1, ncol = 12))
colnames(result_admix_coef) <- c("AML_1.2.3", "AML_1.2.4", "AML_1.3.4",
                              "AML_2.1.3", "AML_2.1.4", "AML_2.3.4",
                              "AML_3.1.2", "AML_3.1.4", "AML_3.2.4",
                              "AML_4.1.2", "AML_4.1.3", "AML_4.2.3"
                              )

result_admix_coef[,1] <- admix_coef("1", "2", "3")
result_admix_coef[,2] <- admix_coef("1", "2", "4")
result_admix_coef[,3] <- admix_coef("1", "3", "4")
result_admix_coef[,4] <- admix_coef("2", "1", "3")
result_admix_coef[,5] <- admix_coef("2", "1", "4")
result_admix_coef[,6] <- admix_coef("2", "3", "4")
result_admix_coef[,7] <- admix_coef("3", "1", "2")
result_admix_coef[,8] <- admix_coef("3", "1", "4")
result_admix_coef[,9] <- admix_coef("3", "2", "4")
result_admix_coef[,10] <- admix_coef("4", "1", "2")
result_admix_coef[,11] <- admix_coef("4", "1", "3")
result_admix_coef[,12] <- admix_coef("4", "2", "3")



  

