library(MCMCpack)
library(bayesplot)

data(Affairs,package = "AER")

head(Affairs)

fit1 = glm(affairs~.,data = Affairs,family = "poisson")

sample2 = MCMCpoisson(affairs~., data = Affairs,burnin = 2000,mcmc = 5000, tune = 0.5)
plot(sample2)
#hist(Affairs$affairs)

