//Number of population samples (demes) - not sampled, simulated
4 samples to simulate (CB, MAC, THAN, EAST)
//Population effective sizes (number of genes -- 2*Ne)
CB
MAC
THAN
EAST
//Sample sizes (CB, MAC, THAN, EAST)
118
42
106
130
//Growth Rates: negative growth = pop expansion forward in time (Nt = N0e^rt, t ~ 20 kya, log(Bsize/Fsize)/time)
CBGRAT
MGRAT
0
0
//Number of migration matrices
3
//migration matrix (backwards in time)
0.0 MIG MIG MIG
MIG 0.0 MIG 0.0
MIG MIG 0.0 MIG
MIG 0.0 MIG 0.0
//migration matrix (backwards in time)
0.0 0.0 MIG MIG
0.0 0.0 0.0 0.0
MIG 0.0 0.0 MIG
MIG 0.0 MIG 0.0
//migration matrix (backwards in time)
0.0 0.0 0.0 0.0
0.0 0.0 0.0 0.0
0.0 0.0 0.0 MIG
0.0 0.0 MIG 0.0
//historical events: time, source, sink, migrants, new size, growth rate, migr. matrix
6 historical event
TBN1 0 0 0 CBRAT keep keep
TBN1 1 1 0 MBRAT keep keep
TDIV1 1 0 0.5 1 0 1
TDIV1 1 2 1 1 0 1
TDIV2 0 3 1 1 0 2
TDIV3 2 3 1 1 0 nomig
//Number of independent loci (chromosomes)
15
//Per chromosome: number of linkage blocks
1
//per block: data type, num loci, rec. rate, mutation rate, optional parameters
MICROSAT 1 0 1e-4 0 0
MICROSAT 1 0 1e-4 0 0
MICROSAT 1 0 1e-4 0 0
MICROSAT 1 0 1e-4 0 0
MICROSAT 1 0 1e-4 0 0
MICROSAT 1 0 8.7e-5 0 0
MICROSAT 1 0 8.7e-5 0 0
MICROSAT 1 0 1e-4 0 0
MICROSAT 1 0 1e-4 0 0
MICROSAT 1 0 1e-4 0 0
MICROSAT 1 0 1e-4 0 0
MICROSAT 1 0 1e-4 0 0
MICROSAT 1 0 1e-4 0 0
MICROSAT 1 0 5.5e-5 0 0
MICROSAT 1 0 5.5e-5 0 0