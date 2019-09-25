#假设k=10;lambda=5;
k=10;
lambda=5;
#计算C=sum_i=0^k p_i
pp_iter = function(j){
	pp = exp(-lambda)*lambda^j/factorial(j);
	return(pp);
}

dicide = function(listall){

			i = as.numeric(listall[1])+1;
			p = lambda*as.numeric(listall[2])/i;
			F = as.numeric(listall[3])+p;
			listall = list(i,p,F);
			return(listall);
		}

X_iter = function(j){
	#生成i=0时的list，其中三个元素代表i,p,F
	listall = list(0,0,0);
	listall[2] = exp(-lambda)/C;
	listall[3] = listall[2];

	for (m in 1:(k+1)) {
			if(u[j]<=listall[3]){
				X=as.numeric(listall[1]);
				m = k+k;
			}else{listall = dicide(as.numeric(listall));}
				m = m+1;
			}
			return(X);
		}

#生成随机数U,以20000个为例
C = sum(sapply(c(0:k),pp_iter));
u = runif(20000);
X = sapply(c(1:length(u)),X_iter);
hist(X)
mean(X)
var(X)





