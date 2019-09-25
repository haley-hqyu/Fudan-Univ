#-------------------------读存数据，并存储----------------------
my.data = read.csv('assign2.csv',header = T);

#将两条链分别存储在X1、X2中，用数字1、2代表A、B；1、2代表L、R
X1 = (cbind(my.data$V1,my.data$V2));
X2 = (cbind(my.data$V3,my.data$V4));

#记录链的长度
N = list(length(X1)/2,length(X2)/2);

#隐状态链列表X以及显状态链列表Y
X = list(X1[,1],X2[,1]);
Y = list(X1[,2],X2[,2]);

#依照两条链，分别求出其转移数量矩阵AA、发射数量矩阵EE

transnum = function(j){
	#给定转移数量矩阵AA
	P = matrix (0,2,2);
    for( i in 1:(N[[j]]-1)){
        P = sapply(c(1:2),function(l) sapply(c(1:2),function(k) P[k,l]+(X[[j]][i] == l)*(X[[j]][i+1] == k)));
    }
    return(P);
}

AA =  lapply(c(1:2),transnum);

emission = function(j){
	#给定发射数量矩阵EE
 	E = matrix(0,2,2);
    for( i in 1:(N[[j]]-1)){
        E = sapply(c(1:2),function(l) sapply(c(1:2),function(k) E[k,l]+(X[[j]][i] == l)*(Y[[j]][i] == k)));
    }
    return(E);
 }

EE = lapply(c(1:2),emission);


#----------------------------MLE估计参数----------------------------

#计算转移矩阵A与发射矩阵E
AA_iter = function(i,j){
	result = sum(sapply(c(1:2),function(k) AA[[k]][i,j]))/sum(sum(sapply(c(1:2),function(k) AA[[k]][,j])));
	return(result);
}

result = sapply(c(1:2),function(j) sapply(c(1:2), function(i) AA_iter(i,j)));
A = matrix(result,2,2);

EE_iter = function(i,j){
    result = sum(sapply(c(1:2),function(k) EE[[k]][i,j]))/sum(sum(sapply(c(1:2),function(k) EE[[k]][,j])));
	return(result);
}

result = sapply(c(1:2),function(j) sapply(c(1:2), function(i) EE_iter(i,j)));
E = matrix(result,2,2);


#--------------------------该隐状态出现的概率--------------

#利用向前、向后方法迭代出f,B

#由于两条链一样长：
N=100;
ff = c(1/2,1/2);
f_iter = function(j){
    f = matrix(0,2,N);
    f[,1] = ff * E[Y[[j]][1],];

    for (i in 2:N ){
        for (I in 1:2){
            f[I,i] = E[Y[[j]][i],I]*(A[I,] %*% f[,i-1]);
        }
    }
    return(f);
}
B_iter = function(j){
    B = matrix(0,2,N);
    for (I in 1:2){
        B[I,N] = 1;
        }
        for (i in (N-1):1 ){
            for (I in 1:2){
                B[I,i] = A[1,I]*E[Y[[j]][i+1],1]*B[1,i+1]+A[2,I]*E[Y[[j]][i+1],2]*B[2,i+1];
            }
        }
        return(B);
}


#迭代出f,B最终结果
nonstop = TRUE;
t = 0;
Tol = 1e-10;

while(nonstop&&t<1000){
    f = lapply(c(1:2),f_iter);
    B = lapply(c(1:2),B_iter);
    P = lapply(c(1:2),function(j) f[[j]][,N]%*%B[[j]][,N]);
    fff = sapply(c(1:2),function(i) sum(sapply(c(1:2),function(j) f[[j]][i,1]*B[[j]][i,1]/P[[j]]/2)));
    #判断停止条件
    nonstop = (abs(fff[1]-ff[1])> Tol);
    ff = fff;

    #记录迭代次数
    t = t+1;
}


#计算P(s_i=l|X)即隐状态的出现的概率

P_iter = function(i,j){
    P = matrix(0,2,1);
    P = f[[j]][,i]*B[[j]][,i];
    return(P);
}

P_xands = lapply(c(1:2),function(j) sapply(c(1:N),function(i) P_iter(i,j)));
P_x = lapply(c(1:2),function(j) sum(f[[j]][,N]));
# 
P_x_s = lapply(c(1:2),function(j) P_xands[[j]]/P_x[[j]]);


#--------------------------------输出结果-----------------------------
cat("The final results are as follows:\n",
	"Transition Probability from A to A is",A[1,1],";\n","Transition Probability from A to B is",A[2,1],";\n",
	"Transition Probability from B to A is",A[1,2],";\n","Transition Probability from B to B is",A[2,2],";\n",
	"Emission Probability from A to L  is",E[1,1],";\n","Emission Probability from A to R  is",E[2,1],";\n",
	"Emission Probability from B to L  is",E[1,2],";\n","Emission Probability from B to R  is",E[2,2],";\n",
    "对于两条链的该隐状态出现的概率为P_x_s[[1]],P_x_x[[2]]"
	)



