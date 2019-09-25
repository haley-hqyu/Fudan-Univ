#假设k=10;lambda=5;
k=10;
lambda=5;

pp_iter = function(j){
	pp = exp(-lambda)*lambda^j/factorial(j);
	return(pp);
}
X_iter = function(i){
		return(listall[[1]][i]);
}

generate = function(N){
	u = runif(N);
	uu = runif(N);
	Y = floor(k*u);
	uuu = pp_iter(Y)/floor(lambda-1);
	num = which(uu<=uuu);
	return(list(Y,num));
}

N = 10^6;
listall = generate(N);
X = sapply(listall[[2]],X_iter);
hist(X)
cc = length(X)/N;

#c,cc
pp_iter = function(j){
     pp = exp(-lambda)*lambda^j/factorial(j);
     return(pp);
 }
 C = sum(sapply(c(0:k),pp_iter));

 hist(X)
 mean(X)
var(X)
 c=k/C*floor(lambda-1);
 ccc = 1/c;

