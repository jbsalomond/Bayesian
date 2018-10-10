library(bayess)
library(MCMCpack)
set.seed(1312)
n = 100
p = 10
X = matrix(runif(n*p),ncol= p)
beta = rnorm(p,sd = 12)

beta[c(2,4,5)] = 0 
Y = X%*%beta + rnorm(n)


data = data.frame(y = Y,X)

fit1 = lm(y~.,data)

b0 = fit1$coefficients
reg = MCMCregress(y~.,data = data,b0 = b0)

# X = caterpillar[,-9]
X = apply(X,2,scale,scale = FALSE)
#y = caterpillar[,9]
y = Y
g = 100
summary(reg)
gamma = rbinom(size = 1,n=p,prob = 0.5)
n = dim(caterpillar)[1]
lpigamma = function(gamma){
  
  Xgamma = as.matrix(X[,which(gamma==1)])
  bgamma = b0[which(gamma==1)+1]
  qgam = sum(gamma)
  if(sum(gamma)>0){
  XX1 = solve(t(Xgamma)%*%Xgamma)
  temp = c(
    sum(y^2) - 
      (g/(g+1))*t(y)%*%Xgamma%*%XX1%*%t(Xgamma)%*%y -
      (1/(g+1))*t(bgamma)%*%t(Xgamma)%*%Xgamma%*%bgamma
  )
  return(log(g+1)*(-(qgam+1)/2) - log(temp)*((n-1)/2))
  }
  else log(g+1)*(-(qgam+1)/2) - log(sum(y^2))*((n-1)/2)
}
lpigamma(gamma)
N = 2000
Burn = 2000
niter = N + Burn
gamma = rbinom(size = 1,n=p,prob = 0.5)
Gammasave = matrix(0,ncol = p,nrow = niter)
Gammasave[1,] = gamma
for(i in 2:niter){
  for(j in 1:p){
    gammat = gamma
    gammat[j] = 0 
    lpi0 = lpigamma(gammat)
    gammat[j] = 1 
    lpi1 = lpigamma(gammat)
    post = exp(lpi1)/(exp(lpi0)+exp(lpi1))
    gamma[j] = rbinom(1,size = 1,prob = post)
  }
  Gammasave[i,] = gamma
}

colMeans(Gammasave[-(1:Burn),])