# the inverse transform method for 2
podd = 0.11;
peven = 0.09;
pp = c(podd,peven);

value = c(5:14);

dicide = function(listall){
	p = listall[[2]] + pp[(listall[[1]]%%2+1)];
	x = listall[[3]]+1;
	ii = listall[[1]]+1;
	listall = list(ii,p,x);
	return(listall);
}

X_iter = function(i){
	p =podd;
	x = value[1];
		listall = list(0,0,0);
		listall[[1]]=1;
		listall[[2]]=p;
		listall[[3]]=x;

	for (m in 1:(length(value)+1)){
		if(u[i]<listall[[2]]){
			X = listall[[3]];
			m = m+length(value);
			}else{ listall = dicide(listall);}
			m = m+1;
			}
			return(X);
}


N = 20000;
u = runif(N);
X = sapply(c(1:N),X_iter);
hist(X)
mean(X)
var(X)

