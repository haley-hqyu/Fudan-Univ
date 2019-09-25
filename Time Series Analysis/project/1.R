for (i in 2:2){
  site=sitelist[i]
  zhutuofull=datab[datab[,2]==site,]
  zhutuofull[zhutuofull[,8]<0,8]=mean(zhutuo[,8])
  zhutuofull[zhutuofull[,6]<0,6]=mean(zhutuo[,6])
  print(c(mean(zhutuofull[,6]),mean(zhutuofull[,8]),var(zhutuofull[,6]),var(zhutuofull[,8]),length(zhutuofull[,8])))
  plot(ts(zhutuofull[,8]),col='red',ylab="pH和溶解氧(mg/L)",main="四川乐山岷江大桥")
  lines(ts(zhutuofull[,6]),col='green')
  text(1500,10,"溶解氧",col='red')
  text(1000,7,"pH",col='green')
}
dataPJ1 = zhutuofull[400:1900,]
tsPJ1 = ts(dataPJ1[,6])
fit = lm(tsPJ1~time(tsPJ1))
plot(tsPJ1, ylab="pH", col='red')
abline(fit)
tsPJ1r = ts(fit$residuals)
plot(tsPJ1r, ylab="pH", col='red')
plot(diff(tsPJ1))
acf(tsPJ1, main="pH")
acf(tsPJ1r, main="detrended")
acf(diff(tsPJ1), main="first difference")

