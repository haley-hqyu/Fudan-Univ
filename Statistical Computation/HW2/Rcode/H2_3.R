#-----------------------读取数据、设置初值---------------------------------

#由于data3与data2的显状态相同，不妨将2.获得的转移矩阵与发射矩阵作为未知的转移矩阵与发射矩阵初值
A = matrix(c(0.8545455,0.1931818,0.1454545,0.8068182),nrow = 2);
E = matrix(c(0.6636364,0.3363636,0.2727273 ,0.7272727),nrow = 2);

#读取数据并存储，Y为显状态
my.data = read.csv('assign3.csv',header = T);
Y = list(c(my.data$V1),c(my.data$V2));
#记录显状态长度，假设已知两条链一样长
N = length(my.data$V1);

#假设初始生成A、B的概率相等，概率矩阵为ff
#向前算法计算，f矩阵即f[l,i]=P(x_1,...,x_i;s_i=l)=e_l(x_i)sum_k(f_k(i-1)*A[l,k])

ff = c(1/2,1/2);
f_iter = function(j){
	f = matrix(0,2,N);
	f[,1] = ff * E[Y[[j]][1],];
	for (i in 2:N ){
		for (l in 1:2){
			f[l,i] = E[Y[[j]][i],l]*(A[l,] %*% f[,i-1]);
		}
	}
	return(f);
}

#此处认为AB之间互相转换概率只和为1，认为最后一步从A、B的结束为必然，概率为1
#向后算法计算B,即 B[l,i]=P(x_i+1,...,x_L|s_i)=sum_(s_i+1)(A[s_i+1,l]*E[s_i+1,x_i+1]*B[s_i+1,i+1])
B_iter = function(j){
	B = matrix(0,2,N);
	for (l in 1:2){
		B[l,N] = 1;
		}
		for (i in (N-1):1 ){
			for (l in 1:2){
				B[l,i] = A[1,l]*E[Y[[j]][i+1],1]*B[1,i+1]+A[2,l]*E[Y[[j]][i+1],2]*B[2,i+1];
			}
		}
		return(B);
}

#输入行、列生成新的转移数量矩阵
AA_iter = function(k,l){
	result = 0;
	for ( j in 1:2 ){	
		pp = 0;
		for (i in 1:N){
			if (i==1){
				pp = pp +0;
			}
			else{
				pp = pp + f[[j]][k,i-1]*A[l,k]*E[Y[[j]][i],l]*B[[j]][l,i];
			}
		}
		result = pp/P[[j]]+result;
	}
	return(result);
}

#输入转移数量矩阵，生成新的转移矩阵A
newtrans = function(i,j){
	result = AA[i,j]/sum(AA[,j]);
	return(result);
}

#输入行列，生成新的发射数量矩阵
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

#输入发射数量矩阵，生成新的发射矩阵E
newemiss = function(i,j){
	result = EE[i,j]/sum(EE[,j]);
	return(result);
}

#--------------------------------循环迭代-------------------------
nonstop = TRUE;
t = 0;
Tol = 1e-10;

while(nonstop&&t<10000){
	#E-step
	f = lapply(c(1:2),f_iter);
	B = lapply(c(1:2),B_iter);
	P = lapply(c(1:2),function(j) f[[j]][,N]%*%B[[j]][,N]);

	#M-step
	ff = sapply(c(1:2),function(i) sum(sapply(c(1:2),function(j) f[[j]][i,1]*B[[j]][i,1]/P[[j]]/2)));
	AA = matrix(sapply(c(1:2),function(k) sapply(c(1:2),function(l) AA_iter(k,l))),2,2);
	EE = matrix(sapply(c(1:2),function(k) sapply(c(1:2),function(b) EE_iter(k,b))),2,2);
	A0 = matrix(sapply(c(1:2),function(j) sapply(c(1:2),function(i) newtrans(i,j))),2,2);
	E = matrix(sapply(c(1:2),function(j) sapply(c(1:2),function(i) newemiss(i,j))),2,2);

	#判断停止条件
	nonstop = (abs(A0[1,1]-A[1,1])> Tol);
	A=A0;
	#记录迭代次数
	t = t+1;
}


#--------------------------------计算最优路径-------------------------

#计算最优隐状态
#v[k,i]=E[x_i,k]*max(A[k,l]*v[l,i-1]
#trace back s_L=argmax(v[k,l]);
#s_i-1=argmax(A[s_i|k]*v[k,i-1]);
chain = function(j){
	v0=1;
	v = matrix(0,2,N);
	maxv = matrix(0,2,N);
	v[,1] = E[2-(Y[[j]][1]==1),]*t(ff);
	for(i in 2:N){
		v[,i] = E[2-(Y[[j]][i]==1),]*apply(A,1, function(m) max(m * v[,i-1]));
		maxv[,i-1] = apply(A,1,function(m) which.max(m * v[,i-1]));
	}
	maxvnum = matrix(0,1,N);
    maxvnum[N] = which.max(v[,N]);
    for(i in (N-1):1){
    	maxvnum[i] = maxv[maxvnum[i+1],i];
    }
    return(maxvnum);
}

#得到两条显链的最优隐状态
chain_explicit = lapply(c(1:2),function(j) chain(j));

#-------------------------屏幕输出-------------------
cat("The final results are as follows:\n",
	"Transition Probability from A to A is",A[1,1],";\n","Transition Probability from A to B is",A[2,1],";\n",
	"Transition Probability from B to A is",A[1,2],";\n","Transition Probability from B to B is",A[2,2],";\n",
	"Emission Probability from A to L  is",E[1,1],";\n","Emission Probability from A to R  is",E[2,1],";\n",
	"Emission Probability from B to L  is",E[1,2],";\n","Emission Probability from B to R  is",E[2,2],";\n",
	"第一条链的最优隐状态为:",chartr("12","AB",c(chain_explicit[[1]])),";\n",
	"第二条链的最优隐状态为:",chartr("12","AB",c(chain_explicit[[2]]))	
	)










