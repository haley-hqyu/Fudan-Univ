N = 10^4;
u1 = runif(N);
X_1 = 1/2*log(2*u1);
X_2 = -1/2*log(2*(1-u1));
u2 = runif(N);
num = which(u2<=1/2);

X_final = function(i){
	if(i %in% num){
		x = X_1[i];
		}else{x = X_2[i];}
	return(x);
}

X = sapply(c(1:N), X_final);

hist(X)

mean(X)
var(X)