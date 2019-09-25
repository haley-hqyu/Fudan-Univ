H4_2_2 = function(N){

#start with0.1，0.1，0.1
x = c(0.1,0.1,0.1);
b = matrix(c(1:3),3,1);
burnin = 1000;

N = N+burnin;
X = matrix(0,N,3);
X[1,]=x;
n = 0;

for (t in 1:N) {

#random walk
z = rnorm(3, mean = 0, sd = 0.09);
xx = x+z;
alpha = exp(-sum(xx)+sum(x))*(sum(xx%*%b)<1)*(xx[1]>0)*(xx[2]>0)*(xx[3]>0);
u = runif(1);
x = (u<alpha)*xx+(u>=alpha)*x;
n = (u<alpha)+n;
X[t,] = x;

}
#hist(X);
#get the mean
mean = mean((X%*%b)[1001:N,]);
return(list(X,mean));
}