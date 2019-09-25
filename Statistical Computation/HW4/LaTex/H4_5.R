#generate 2-dim norm distribution


#set sigma,u,mean
sigma1 = matrix(c(1,0.3,0.3,2),2,2);
sigma2 = matrix(c(3,0.4,0.4,1),2,2);
sigma = list(sigma1,sigma2);

u1 = matrix(c(1,4),2,1);
u2 = matrix(c(-2,-1),2,1);
u = list(u1,u2);

x1 = matrix(c(1,4),2,1);
x2 = matrix(c(-2,-1),2,1);
x = list(x1,x2);

N = 5000;

X = matrix(0,N,2);


#generate X

X_generate = function(I){
n  = 0;
for (t in 1:N) {

z = matrix(rnorm(2, mean = 0, sd = 2),2,1);
xx = x[[I]]+z;
alpha = exp(-1/2*t(xx-u[[I]])%*%solve(sigma[[I]])%*%(xx-u[[I]])+1/2*t(x[[I]]-u[[I]])%*%solve(sigma[[I]])%*%(x[[I]]-u[[I]]));

uu = runif(1);
if(uu<alpha){x[[I]] = xx;n=n+1;}

X[t,] = x[[I]];
}
n/N;
return(X);
}

X1=X_generate(1);
X2=X_generate(2);
XX = list(X1,X2);

#generate mixed X

for(t in 1001:N){
#choose I,J differently
I=floor(runif(1)*2)+1;
X[t-1000,]=XX[[I]][t,];
}

plot(X)

#作等高线图
xmin  =floor(min(X[,1]))
xmax  =ceiling(max(X[,1]))
ymin  =floor(min(X[,2]))
ymax  =ceiling(max(X[,2]))

fx = function(x,y,I){
	x = matrix(c(x,y),2,1);
	result = 1/(2*pi*sqrt(det(sigma[[I]])))*exp(-1/2*t(x-u[[I]])%*%solve(sigma[[I]])%*%(x-u[[I]]));
	return(result);
}

  x = seq(xmin,xmax,length.out = 200);
  y = seq(ymin,ymax,length.out = 200);
  
  result = sapply(y,function(y) sapply(x, function(x) fx(x,y,1)+fx(x,y,2)));

  z = matrix(c(result),nrow = 200,ncol = 200);
  contour(x,y,z,add = TRUE);


