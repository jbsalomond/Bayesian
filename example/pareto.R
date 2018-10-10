library(actuar)
setwd("~/Dropbox/Taff/Teaching/CEPE/example/")
n= 100
alpha = 4
theta = 2
X = rpareto(n,shape=alpha,scale=theta)
X = X+theta 


library(rstan,quietly=TRUE)
data.pareto<-list(n = n,X = X)
fit.pareto<-stan(file='pareto.stan',data=data.pareto,iter=10000,chains=1,warmup=5000,control = list(adapt_delta = 0.99999))
output = extract(fit.pareto)

