data{
  int<lower = 0> n; 
  int<lower = 0> p; 
  matrix[n,p] X ; 
  int Y[n] ; 
}
parameters{
  vector[p] beta ; 
}
model{ 
beta ~ cauchy(0,1);
for(i in 1:n)
  Y[i] ~ poisson(exp(X[i,]*beta));
}
