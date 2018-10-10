library(MCMCpack)
library(bayesplot)
set.seed(321)
n = 50
theta0 = 2
sigma = 1
X = rnorm(n,m = theta0,sd = sigma)

lpost = function(x){
  sum(dnorm(X,m=x,sd = sigma,log=T)) + dt(x = x,log=T,df = 3)
}


sample = MCMCmetrop1R(fun = lpost,theta.init = 0,burnin = 5000,mcmc = 10e3,
                      verbose = T,logfun=T,tune = 3.3)
colnames(sample) = "theta"
hist(sample,prob = T)

mcmc_combo(x = sample)
mcmc_acf(sample)
mcmc_areas(sample,prob = 0.95)
