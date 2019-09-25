H4_4 = function(N,alpha,beta,lambda){

#choose x,y,n
n = 10;
x = ceiling(runif(1)*n);
y = runif(1);
burnin = 1000;
N <- N + burnin;

L = matrix(0,N,3);
L[1,] = matrix(c(x,y,n),1,3);

#generate
for (t in 2:N){

#choose one to change	
U = ceiling(runif(1)*3);
L[t,-U] = L[(t-1),-U];

switch(U,
           L[t,1] <- rbinom(1, L[t,3], L[t,2]),
           L[t,2] <- rbeta(1, L[t,1] + alpha, L[t,3] - L[t,1] + beta),
           L[t,3] <- rpois(1, lambda * (1 - L[t,2]))+L[t,1]
           )

}
Ex = mean(L[1001:N,1]);
Ey = mean(L[1001:N,2]);
En = mean(L[1001:N,3]);
return(list(L[1001:N,],Ex,Ey,En))
}