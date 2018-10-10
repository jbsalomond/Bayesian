data{
	int J;
	int N;
	int Y[N];
	real X[N];
	real<lower=0> sigma;
}

parameters{
	real theta[J];
}


model{
	for(i in 1:N)
	{
		Y[i]~bernoulli(inv_logit(X[i]*theta[2]+theta[1]));
	}
	for(j in 1:J)
	{
		theta[j]~cauchy(0.0,sigma);
	}
}

