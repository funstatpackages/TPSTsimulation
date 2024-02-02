rm(list = ls())

library(pracma)
library(Matrix)
library(parallel)

source("basis3D.R")
source("basis3DFns.R")
source("dataGeneratorHS.R")
source("energyM3D.R")
source("energy3DFns.R")
source("smoothness3D.R")
source("smoothness3DFns.R")
source("thdata.R")
source("bary.R")
source("qrH.R")
source("TPST_est.R")
source("findNabr.R")
source("insideVT.R")
source("tpst.npd.global.R")
source("pointLocation3D.worker.parLapply.R") 

# Example: 3D horseshoe
load("V1.rda");
load("Th1.rda");

# load("V2.rda");
# load("Th2.rda");

V <- as.matrix(V1); Th <- as.matrix(Th1);
# V <- as.matrix(V2); Th <- as.matrix(Th2);

x0 <- seq(-0.85, 3.35, by = 0.1); cat("nx =", length(x0), "\n")
y0 <- seq(-0.85, 0.85, by = 0.1); cat("ny =", length(y0), "\n")
z0 <- seq(-0.45, 0.45, by = 0.1); cat("nz =", length(z0), "\n")

# parameters
d <- 2; r <- 1;
sig <- 5
missing <- 0 # missing type = 1, 2, 3
nSIM.start <- 1
nSIM <- 1
n <- 50000 # sample_size = 50000; 100000; 500000 
# parallel method: 
# pmethod = 1 for mclapply (ns = 1 for Windonws); 
# pmethod = 2 for parLapply
# pmethod <- 2 

mt.1 <- proc.time()[3]
result.list <- tpst.npd.global(V, Th, d, r, x0, y0, z0, sig, missing, nSIM.start, nSIM, n)
computing.main.time.global <- proc.time()[3] - mt.1
average.computing.main.time.global <- computing.main.time.global/ nSIM
print(computing.main.time.global)
print(average.computing.main.time.global)
print(round(result.list$ave.mise, 4))
print(round(result.list$ave.mspe, 4))
print(round(result.list$ave.miss.rate, 4))
print(result.list)
