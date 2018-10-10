data{
  int<lower = 0> n ; 
  int<lower = 0> p ;
  vector[n] Y ;
  matrix[n,p] X; 
  real<lower = 0> lambda ; 
}

parameters{
  vector[p] beta ;
  
}

model{
  Y ~ multi_normal(X*beta, diag_matrix(rep_vector(1.0,n))) ;
  beta ~ multi_normal(rep_vector(0,p),diag_matrix(rep_vector(lambda,p))) ;
}