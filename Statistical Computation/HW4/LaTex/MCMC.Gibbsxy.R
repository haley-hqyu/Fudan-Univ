MCMC.Gibbsxy =function(N,B){

burnin = 1000;
N = N+burnin;

#choose x,y;
x = runif(1)*B;
y = runif(1)*B;

#set L
L = matrix(0,N,2);
L[1,] = matrix(c(x,y),1,2);

for (t in 2:N){

#choose x or y to change firstly
num = ceiling(runif(1)*2);

#change num-th 
u = runif(1);
L[t,num] = -1/L[t-1,(3-num)]*log(1-u*(1-exp(-L[t-1,(3-num)]*B)));
#change the other
u = runif(1);
L[t,(3-num)] = -1/L[t,num]*log(1-u*(1-exp(-L[t,num]*B)));
}

#get the mean
ex = mean(L[1001:N,1]);
exy =mean(L[1001:N,1]*L[1001:N,2]);
return(list(L,ex,exy));
}