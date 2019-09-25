library(astsa)
#Problem 3.10(a)
fitCmort = ar.ols(cmort, order.max = 2, demean = F, intercept = T)
#Problem 3.10(b)
predictCmort = predict(fitCmort, n.ahead = 4)
intervals = matrix(c(predictCmort$pred + predictCmort$se * qnorm(0.025),
                     predictCmort$pred + predictCmort$se * qnorm(0.975)),4,2)
print(intervals)
