function solution= piecewise2(lambda,k,y,a,b,n)
%PIECEWISE2 此处显示有关此函数的摘要
%   此处显示详细说明
Lambda=lambda*eye(n+1);
h=(b-a)/n;
ti=linspace(a,b,n+1);
for i=1:n+1
    k1=@(t)k(t,ti(1)).*(ti(2)-t)/h;
    A(i,1)=quad(k1,ti(1),ti(2));
    for j=2:n
        k1=@(t)k(t,ti(j)).*(t-ti(j-1))/h;
        k2=@(t)k(t,ti(j)).*(ti(j+1)-t)/h;
        A(i,j)=quad(k1,ti(j-1),ti(j))+quad(k2,ti(j),ti(j+1));
    end
    k1=@(t)k(t,ti(n+1)).*(t-ti(n))/h;
    A(i,n+1)=quad(k1,ti(n),ti(n+1));
    k2=@(t)y(t).*(t-ti(i-1))/h;
    k3=@(t)y(t).*(ti(i+1)-t)/h;
    if i==1
        B(i,1)=quad(k3,ti(i),ti(i+1));
    elseif i==n+1
        B(i,1)=quad(k2,ti(i-1),ti(i));
    else
        B(i,1)=quad(k2,ti(i-1),ti(i))+quad(k3,ti(i),ti(i+1));
    end
end
c=(Lambda-A)\B;
solution=@(t)0;
for i=1:n+1
    solution=@(t)solution(t)+c(i).*k(t,ti(i));
end
solution=@(t)(solution(t)+y(t))/lambda;
end

