#Problem 3.9

n = 1000
arma11 = arima.sim(n = n, list(ar = 0.6, ma = 0.9))
arma10 = arima.sim(n = n, list(ar = 0.6))
arma01 = arima.sim(n = n, list(ma = 0.9))

acf(arma11);acf(arma10);acf(arma01)

pacf(arma11);pacf(arma10);pacf(arma01)

#Problem 3.12

