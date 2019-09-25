#-----------
#初值和你的一样 不过A、E都是你的转制形式

A = (matrix(c(0.7,0.3,0.1,0.9),nrow = 2));

E = matrix(c(0.2,0.8,0.8,0.2),nrow = 2);

my.data = read.csv('assign3.csv',header = T);
Y = list(c(my.data$V1),c(my.data$V2));

N = length(my.data$V1);

#最开始生成A、B的概率假设相等


#forward算，f计算

ff = c(1/2,1/2);

f_iter = function(j){
	f = matrix(0,2,N);
	f[,1] = ff * E[2-(Y[[j]][1] == 1),];

	for (i in 2:N ){
		for (I in 1:2){
			f[I,i] = E[2-(Y[[j]][i] == 1),I]*(A[I,] %*% f[,i-1]);
		}
	}
	return(f);
}





#结束时A、B的结束概率假设相等

#backward算法计算b
B_iter = function(j){
	B = matrix(0,2,N);
	for (I in 1:2){
		B[I,N] = 1;
		}
		for (i in (N-1):1 ){
			for (I in 1:2){
				B[I,i] = A[1,I]*E[2-(Y[[j]][i+1] == 1),1]*B[1,i+1]+A[2,I]*E[2-(Y[[j]][i+1] == 1),2]*B[2,i+1];
			}
		}
		return(B);
}






#计算Akl\Ekb





#迭代生成新的转移矩阵

AA_iter = function(k,l){
	result = 0;
	for ( j in 1:2 ){
		
		pp = 0;
		for (i in 1:N){

			if (i==1){
				pp = pp + ff[k]*A[l,k]*E[2-(Y[[j]][i] == 1),l]*B[[j]][l,i];
			}
			else{
				pp = pp + f[[j]][k,i-1]*A[l,k]*E[2-(Y[[j]][i] == 1),l]*B[[j]][l,i];
			}
		}


		result = pp/P[[j]]+result;
	}
	return(result);
}

#result = sapply(c(1:2),function(k) sapply(c(1:2),function(l) AA_iter(k,l)));



#新的转移矩阵A
newtrans = function(i,j){
	result = AA[i,j]/sum(AA[,j]);
	return(result);
}



#迭代生成新的发射矩阵

EE_iter = function(k,b){
	result = 0;
	for ( j in 1:2 ){
		p = 0;

		for (i in 1:N){

			if (Y[[j]][i] == b){
				p = p + f[[j]][k,i]*B[[j]][k,i];
			}
			else{
				p = p + 0;
			}
		}
		result = p/P[[j]]+result;
	}
	return(result);
}
#result = sapply(c(1:2),function(k) sapply(c(1:2),function(b) EE_iter(k,b)));
#EE = matrix(result,2,2);

#新的发射矩阵E
newemiss = function(i,j){
	result = EE[i,j]/sum(EE[,j]);
	return(result);
}


#f = lapply(c(1:2),f_iter);
#B = lapply(c(1:2),B_iter);
#P = lapply(c(1:2),function(j) sum(f[[j]][,N]));
#A = matrix(sapply(c(1:2),function(i) sapply(c(1:2),function(j) newtrans(i,j))),2,2);
#E = matrix(sapply(c(1:2),function(i) sapply(c(1:2),function(j) newemiss(i,j))),2,2);
#ff = sapply(c(1:2),function(i) sum(sapply(c(1:2),function(j) f[[j]][i,1]*B[[j]][i,1]/P[[j]]))/2);

#--------------------------------循环迭代-------------------------
nonstop = TRUE;
t = 0;
Tol = 1e-10;

while(nonstop&&t<1000){

	f = lapply(c(1:2),f_iter);
	B = lapply(c(1:2),B_iter);
	P = lapply(c(1:2),function(j) f[[j]][,N]%*%B[[j]][,N]);
	AA = matrix(sapply(c(1:2),function(k) sapply(c(1:2),function(l) AA_iter(k,l))),2,2);
	EE = matrix(sapply(c(1:2),function(k) sapply(c(1:2),function(b) EE_iter(k,b))),2,2);
	A0 = matrix(sapply(c(1:2),function(i) sapply(c(1:2),function(j) newtrans(i,j))),2,2);
	E = matrix(sapply(c(1:2),function(i) sapply(c(1:2),function(j) newemiss(i,j))),2,2);
	ff = sapply(c(1:2),function(i) sum(sapply(c(1:2),function(j) f[[j]][i,1]*B[[j]][i,1]/P[[j]]))/2);

	nonstop = (abs(A0[1,1]-A[1,1])> Tol);
	A=A0;

	t = t+1;
}

