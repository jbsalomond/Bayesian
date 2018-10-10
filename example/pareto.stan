data{
  int<lower = 0> n;
  vector[n] X;
  real<lower = 0> alpha;
}

parameters{
  real<lower = 0> theta;
}

model{
  theta~gamma(3,3);
  X~pareto(theta,alpha);
}
