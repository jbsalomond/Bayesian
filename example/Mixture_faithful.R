library(rstan)
library(bayesplot)

setwd("~/Dropbox/Taff/Teaching/CEPE/example/")
data = faithful
X = faithful$eruptions
standata = list(X=X,n = length(X))
fit = stan("Mixture_faithful.stan",data = standata,warmup = 1000,iter = 3000,chains = 1)

resfit = summary(fit)

hist(X,prob = T,nclass = 30)
abline(v = resfit$summary[2,1])
abline(v = resfit$summary[3,1])

mcmc_areas(as.array(fit),pars = c("mu1"),prob = .9)
mcmc_areas(as.array(fit),pars = c("mu2"),prob = .9)

n = 200
Z = rbinom(n,size = 1,prob = 0.3)
X = rnorm(n,4,0.2)*Z + rnorm(n,1,0.4)*(1-Z)

standata = list(X=X,n = length(X))
fitout = stan("Mixture_faithful.stan",data = standata,warmup = 1000,iter = 4000,chains = 1)
summary(fitout)

mcmc_areas(as.array(fitout),pars = c("lambda","mu1","mu2","s1","s2"),prob = .9)
