library(astsa)
ss = sunspotz
ss.per = spec.pgram(sunspotz, taper = 0, log = 'no', detrend = T)
abline(v = 1/10, lty = 'dotted')
abline(v = 22/240, lty = 'dotted')

ss.per$spec[24]
U = qchisq(0.025,2)
L = qchisq(1 - 0.025,2)
2*ss.per$spec[22]/L
2*ss.per$spec[22]/U

2*ss.per$spec[24]/L
2*ss.per$spec[24]/U