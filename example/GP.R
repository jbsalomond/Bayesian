

n = 100
sigma = 1
f = function(x) 0.5*(x^2+1)^2*exp(cos(3*pi*x))

X = rbeta(n,shape1 = 2,shape2 = 2)

Y = f(X) + rnorm(n,sd = sigma)
curve(f)
points(X,Y)

K = function(x,y,b) sqrt(b)*exp(-b*(x-y)^2)
a = 1
b = 50
tau = 10e-10
Kxx = outer(X,X,K,b)
Kxx1 = Kxx#solve(Kxx + tau*diag(n))

Q = solve(Kxx1 + (sigma^2)*diag(n))

thetahat = Q%*%Y
library(ggplot2) 
xi = seq(0,1,length.out = n)
fhat = rep(0,n)
ftop = rep(0,n)
fdown = rep(0,n)
for(i in 1:n){
x = xi[i]
newK = K(x,X,b)
ZZ = K(x,x,b) - t(newK)%*%Q%*%(newK)
fhat[i] = t(newK)%*%thetahat

ftop[i] = qnorm(p=0.975,mean = fhat[i],sd=sqrt((ZZ)))
fdown[i] = qnorm(p=0.025,mean = fhat[i],sd=sqrt((ZZ)))
}
df = data.frame(x = xi,Xpoints = X,Y = Y,true = f(xi),mean = fhat,up = ftop,down = fdown)

ggplot(data = df,aes(x=x)) + geom_point(aes(x = Xpoints,y = Y)) + 
  geom_line(aes(y = true)) + geom_ribbon(aes(max = up,min = down),fill = "blue",alpha = 0.2) + 
  geom_line(aes(y=mean),col = "red",lty = 2) + theme_bw()

