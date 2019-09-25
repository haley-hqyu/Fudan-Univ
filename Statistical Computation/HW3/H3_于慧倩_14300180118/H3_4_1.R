
generate = function(N){
	Y = runif(N);
	u = runif(N);
	num = which(u<=16*Y^2*(Y-1)^2);
	return(list(Y,num));
}



N = 10^5;

listall = generate(N);



X = listall[[1]][listall[[2]]];

hist(X)
mean(X)
var(X)
cc = length(X)/N
ccc = 8/15