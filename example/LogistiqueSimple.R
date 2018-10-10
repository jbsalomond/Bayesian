library(rstan,quietly=TRUE)
library(mcsm,quietly=TRUE)
library("bayesplot")
library("rstanarm")
library("ggplot2")
library(bridgesampling)
library(dplyr)


data(challenger)
Y<-challenger$oring
X<-challenger$temp

setwd(dir = "~/Dropbox/Taff/Teaching/CEPE/example/")
data.oring<-list(J=2,N=length(Y),sigma=.1,X=X,Y=Y)

fit.oring<-stan(file='logit.oring.stan',data=data.oring,iter=5000,chains=1,warmup=500)
theta<-extract(fit.oring)$theta

colnames(theta) = c("intercept","temp")
dataH0<-list(J=1,N=length(Y),sigma=.1,X=X,Y=Y)
fitH0<-stan(file='logit.oring.stan',data=data.oring,iter=5000,chains=1,warmup=500)

m1 = bridge_sampler(fit.oring)
m0 = bridge_sampler(fitH0)

bf(x1 = m0,x2 = m1,log = TRUE)
