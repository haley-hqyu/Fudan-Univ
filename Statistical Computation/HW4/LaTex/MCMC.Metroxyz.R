
MCMC.Metroxyz = function(a,b,c){

#set x,y,z = 1;
x = c(1,1,1);

#set sigma
sigma = 0.3;

N = 10^4;
X = matrix(0,N,3);
n = 0;

for (t in 1:N) {

#random walk
z = rnorm(3, mean = 0, sd = sigma);
xx = x+z;


alpha = exp(-sum(xx)+sum(x)-xx[1]*xx[2]-xx[1]*xx[3]-xx[2]*xx[3]+x[1]*x[2]+x[1]*x[3]+x[2]*x[3])*(xx[1]>0)*(xx[2]>0)*(xx[3]>0);

u = runif(1);
x = (u<alpha)*xx+(u>=alpha)*x;
n = (u<alpha)+n;

X[t,] = x;
}
#hist(X[,1]+X[,2]+X[,3]+X[,1]*X[,2]+X[,1]*X[,3]+X[,3]*X[,2]);
#hist(X);
#n/N;

#get the mean
mean = mean(X[1001:N,1]*X[1001:N,2]*X[1001:N,3]);
return(list(X,mean));
}
