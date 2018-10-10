library(MASS)
library(MCMCpack)
library(rstan)


n = 100 
p = 120
X = matrix(rnorm(n*p),ncol = p) 
Z = rbinom(p,size = 1, prob = 20/p)
beta = 5*Z*rbeta(p,shape1=4,shape2 = 4)

Y = X%*%beta + rnorm(n)

lambda = 0.3
# Ridge 
datalist = list(X = X, Y = c(Y), n = n, p=p,lambda = lambda)
#post = stan("~/Dropbox/Taff/Teaching/CEPE/example/Ridge.stan",
#            data =datalist,
#            chains = 1,warmup = 1000,iter = 2000
#            )

#bsample = extract(post)$beta


SigPost = solve(t(X)%*%X + diag(p)/lambda)
bmean = SigPost %*% t(X)%*%Y
plot(beta)
points(bmean,pch = 2 , col = "red")

library(mvtnorm)

#bsample = mvrnorm(n = 2000,mu = bmean,Sigma = SigPost)
plot(beta)
points(qnorm(0.975,mean = bmean,sd = sqrt(diag(SigPost))), pch = "-",col = "red")
points(qnorm(0.025,mean = bmean,sd = sqrt(diag(SigPost))), pch = "-",col = "red")
points(bmean,pch = "x", col = "blue")
segments(x0 = seq(1:p), 
         y1 = qnorm(0.975,mean = bmean,sd = sqrt(diag(SigPost))), 
         x1 = seq(1:p), 
         y0 = qnorm(0.025,mean = bmean,sd = sqrt(diag(SigPost))),
         lty = 2,col = "red"
         )

