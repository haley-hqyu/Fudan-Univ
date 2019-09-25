H4_2_1 = function(N){

#start with 5,5,5
x = c(5,5,5);

burnin = 1000;
N = N + burnin;

#set X
X = matrix(0,N,3);
X[1,]=x;

for(t in 1:N){
	
#choose I,J differently
I=floor(runif(1)*3)+1;
J=I;
while(J==I){
J=floor(runif(1)*3)+1;}
if(I>J){II=I;I=J;J=II;}

x[I]=rexp(1,1-I/J);
u = runif(1);
x[J]=(15-I*x[I]-(6-I-J)*x[6-I-J])/J-log(1-u);
X[t,]=x;
}
b=matrix(c(1:3),3,1);
mean = mean((X%*%b)[1001:N,]);
return(list(X,mean));
}