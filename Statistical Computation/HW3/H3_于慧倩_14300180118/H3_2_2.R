podd = 0.11;
peven = 0.09;
pp = c(peven,podd);


generate = function(N){
	u = runif(N);
	uu = runif(N);
	Y = floor(10*u)+5;
	uuu = pp[(Y%%2+1)]/0.11;
	num = which(uu<=uuu);
	return(list(Y,num));
}

N = 10^5;
listall = generate(N);

X = listall[[1]][listall[[2]]];
hist(X)
mean(X)
var(X)
cc = length(X)/N
ccc = 1/1.1