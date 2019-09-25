projectData = read.csv(file.choose(), header = F)
projectData = as.matrix(projectData)
LiangJ = matrix(projectData[projectData[,3]=="四川宜宾凉姜沟"],ncol=15)
LeShan = matrix(projectData[projectData[,3]=="四川乐山岷江大桥"],ncol=15)

pHLJ = vapply(as.vector(LiangJ[,6]), as.double, c(0))
pHLS = vapply(as.vector(LeShan[,6]), as.double, c(0))
pHLS[pHLS<6]=round(mean(pHLS),digits = 2)
pHLJ[pHLJ<6]=round(mean(pHLJ),digits = 2)
pHLJ = SMA(pHLJ)
pHLS = SMA(pHLS)

plot(pHLS[300:1799], ylab='pH', ylim = c(6,9), col=2, type='l')
lines(pHLJ[300:1799], col=3)
pHLS = pHLS[300:1799]
pHLJ = pHLJ[300:1799]

plot(pHLS, pHLJ, xlab='下游', ylab='上游', pch=20)

dfLS = diff(pHLS)
dfLJ = diff(pHLJ)
ccf(dfLS, dfLJ, main='上游 vs 下游')

#Oxygen
pHLJ = vapply(as.vector(LiangJ[,8]), as.double, c(0))
pHLS = vapply(as.vector(LeShan[,8]), as.double, c(0))
pHLS[pHLS<3]=round(mean(pHLS),digits = 2)
pHLJ[pHLJ<3]=round(mean(pHLJ),digits = 2)
pHLJ = SMA(pHLJ)
pHLS = SMA(pHLS)

plot(pHLS[300:1799], ylab='pH', ylim = c(5,11), col=2, type='l')
lines(pHLJ[300:1799], col=3)
pHLS = pHLS[300:1799]
pHLJ = pHLJ[300:1799]

plot(pHLS, pHLJ, xlab='下游', ylab='上游', pch=20)

dfLS = diff(pHLS)
dfLJ = diff(pHLJ)
ccf(dfLS, dfLJ, main='上游 vs 下游')