y=[ 1 5 5 5 8 8 11 9 13 21 26 24 31 39 44 46 53 48 43 40 34 43 30 30 23 25 24 16 20 18 11 7 4 2 ];
x=1:34;
X=ones(1,767);
for i=1;
    X(i)=1;
end
for k=2:34;
    for i=sum(y(1:k-1)):sum(y(1,1:k));
        X(i)=k;
    end
end
plot(X)
alpha=0.05;
X=X';
[mu,sigma]=normfit(X);
p1=normcdf(X,mu,sigma);
[H1,s1]=kstest(X,[X,p1]);
n=length(X); 
if H1==0
    disp('该数据服从正态分布')
else disp('该数据不服从正态分布')
end
lamda=poissfit(X,alpha);
p2=poisscdf(X,lamda);
[H2,s2]=kstest(X,[X,p2],alpha);
if H2==0
    disp('该数据服从泊松分布')
else disp('该数据不服从泊松分布')
end

