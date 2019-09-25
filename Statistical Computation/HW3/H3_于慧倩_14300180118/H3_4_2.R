
generate = function(N){
	u1 = runif(N);
	Y = 0*c(1:N);
	for(i in 1:N){
		Y[i]=uniroot(function(x) 2*x^3-3*x^2+u1[i],lower = 0,upper = 1)$root;
	}
	u = runif(N);
	num = which(u<=-4*Y*(Y-1));
	return(list(Y,num));
}



N = 10^4;

listall = generate(N);

X = listall[[1]][listall[[2]]];

hist(X)
mean(X)
var(X)
cc = length(X)/length(listall[[1]])
ccc = 4/5