library(MASS)
library(MCMCpack)
library(rstan)
library(bridgesampling)
library(dplyr)
setwd("~/Dropbox/Taff/Teaching/CEPE/example/")

data = Pima.tr

data$type = as.numeric(data$type) - 1


X = model.matrix(type~.,Pima.tr)
Y = data[,8]

#X = X%>% mutate_all(scale)
data.oring<-list(J=dim(X)[2],N=length(Y),sigma=1,X=X,Y=Y)

fit.oring<-stan(file='LogitTest.stan',data=data.oring,iter=10000,chains=1,warmup=1000)

summary(fit.oring)


dataH0<-list(J=dim(X)[2]-1,N=length(Y),sigma=1,X=X[,-2],Y=Y)

fitH0<-stan(file='LogitTest.stan',data=data.oring,iter=10000,chains=1,warmup=1000)

m0 = bridge_sampler(fitH0)
m1 = bridge_sampler(fit.oring)

bf(m0,m1,log = T)
