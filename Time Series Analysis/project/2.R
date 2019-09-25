projectData = read.csv(file.choose(), header = F)
projectData = as.matrix(projectData)
LeShan = matrix(projectData[projectData[,3]=="四川乐山岷江大桥"],ncol=15)
AnQing = matrix(projectData[projectData[,3]=="安徽安庆皖河口"],ncol=15)
SVpH = LeShan[400:1899,]
pHs = as.vector(SVpH[,6])
pH = vapply(pHs, as.double, c(0))
tspH = ts(pH)
trendpH = lm(pH~c(1:1500))
detrpH = ts(detrend(pH))
dfdtpH = diff(detrpH)
# plot of pacf
pacf(tspH, main = 'PACF of pH')
pacf(detrpH, main = 'PACF of detrended pH')
pacf(dfdtpH, main = 'PACF of first difference')
#arima model
nAhead = 100
detrpH.fit = auto.arima(detrpH)
detrpH.pred = predict(detrpH.fit, n.ahead = nAhead)

ts.plot(detrpH, detrpH.pred$pred)
lines(detrpH.pred$pred, type="p", col=2)
lines(detrpH.pred$pred+detrpH.pred$se, lty="dashed", col=24)
lines(detrpH.pred$pred-detrpH.pred$se, lty="dashed", col=24)

pHtest = LeShan[400:1999,6]
pHt = vapply(pHtest, as.double, c(0))
detrpHt = pHt - c(1:1600) * trendpH$coefficients[2] - trendpH$coefficients[1]
detrpHt[1:1500] = NA
lines(detrpHt, col='green')

#with oxygen
oxy = vapply(as.vector(SVpH[,8]), as.double, c(0))
tsOxy = ts(oxy)
plot(tsOxy, col=3)
lines(tspH, col=2)

#scatterPlot
plot(tsOxy, tspH, xlab = 'pH', ylab='溶解氧')

#ccf
detrOxy =  ts(detrend(oxy))
t.1=as.vector(t(detrpH))
t.2=as.vector(t(detrOxy))
ccf(t.1, t.2, main = 'ccf of detrended pH and Oxygen')
