
smapH = SMA(pH)
smapH[is.na(smapH)]=mean(smapH[!is.na(smapH)])

trendsmapH = lm(smapH~c(1:1500))
detrsmapH = ts(detrend(smapH))
dfdtsmapH = diff(detrsmapH)
# plot of acf and pacf
acf(smapH, main = 'ACF of pH')
acf(detrsmapH, main = 'ACF of detrended pH')
acf(dfdtsmapH, main = 'ACF of first difference')
pacf(smapH, main = 'PACF of pH')
pacf(detrsmapH, main = 'PACF of detrended pH')
pacf(dfdtsmapH, main = 'PACF of first difference')
#arima model
nAhead = 100
detrpH.fit = auto.arima(detrsmapH)
detrpH.pred = predict(detrpH.fit, n.ahead = nAhead)

ts.plot(detrsmapH, detrpH.pred$pred)
lines(detrpH.pred$pred, type="p", col=2)
lines(detrpH.pred$pred+detrpH.pred$se, lty="dashed", col=24)
lines(detrpH.pred$pred-detrpH.pred$se, lty="dashed", col=24)

pHtest = LeShan[400:1999,6]
pHt = vapply(pHtest, as.double, c(0))
detrpHt = pHt - c(1:1600) * trendpH$coefficients[2] - trendpH$coefficients[1]
detrpHt[1:1500] = NA
lines(detrpHt, col='green')


k=kernel('daniell', 10)
spec.pgram(pH, k, taper = 0, log='no')
