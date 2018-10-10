data{
  int<lower = 0> n;
  vector[n] X ; 
}
parameters{
  real<lower = 0,upper = 1> lambda ;
  real mu1 ; 
  real mu2 ; 
  real<lower = 0> s1 ; 
  real<lower = 0> s2 ; 
}
model{
  for(i in 1:n)
    target += log_mix(lambda, 
    normal_lpdf(X[i]|mu1,s1), 
    normal_lpdf(X[i]|mu2,s2)) ; 

  lambda ~ beta(1,1) ;
  mu1 ~ normal(0,100) ; 
  mu2 ~ normal(0,100) ; 
  s1 ~ inv_gamma(1,1); 
  s2 ~ inv_gamma(1,1); 
}
