data{
	int J;
	int N;
	int Y[N];
	matrix[N,J] X;
	real<lower=0> sigma;
}

parameters{
	vector[J] theta;
}


model{
	for(i in 1:N)
	{
	  real p ;
	  row_vector[J] Xi ; 
	  Xi = row(X,i) ; 
	  p = inv_logit(Xi*theta) ; 
		Y[i]~bernoulli(p);
	}
	for(j in 1:J)
	{
		theta[j]~cauchy(0.0,sigma);
	}
}

