
generate = function(N){
	u = runif(N);
	Y = -3*log(1-u);
	uu = runif(N);
	num = which(uu<=1/9*Y^2*exp(2-2/3*Y)*(Y>=0));
	return(list(Y,num));
}


N = 10^5;

listall = generate(N);


X = listall[[1]][listall[[2]]];

#hist(listall[[1]])
hist(X)
mean(X)
var(X)
length(X)
M=length(which(listall[[1]]>=0));
cc = length(X)/M
ccc = 1/(27/2*exp(-2))