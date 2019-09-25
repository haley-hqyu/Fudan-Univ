function c = galerkin(k_0,y,lambda,n)
%GALERKIN Galerkin方法，为方便计算,取积分区间为[0,2*pi],取{1/(2*pi),1/pi*cos(t),1/pi*sin(t),..
%,1/pi*cos(n*t),1/pi*sin(n*t)}为基函数.对于一般区间的情形，可用变量代换处理 
%input:k:积分核
%      y:右端项
%      lambda:\lambda
%      n:取基函数为{1/(2*pi),1/pi*cos(t),1/pi*sin(t),..,1/pi*cos(n*t),1/pi*sin(n*t)}
%output:c:基函数的系数向量
L=lambda*eye(2*n+1);
A=zeros(2*n+1,2*n+1);
Y=zeros(2*n+1,1);
Y(1,1)=integral(y,0,2*pi)/sqrt(2*pi);
A(1,1)=integral2(k_0,0,2*pi,0,2*pi)/(2*pi);
for j=1:n
    k1=@(t,s)k_0(t,s).*cos(j*s);
    A(1,2*j)=integral2(k1,0,2*pi,0,2*pi)/(sqrt(2)*pi);
    k2=@(t,s)k_0(t,s).*sin(j*s);
    A(1,2*j+1)=integral2(k2,0,2*pi,0,2*pi)/(sqrt(2)*pi);
    k1=@(t,s)k_0(t,s).*cos(j*t);
    A(2*j,1)=integral2(k1,0,2*pi,0,2*pi)/(sqrt(2)*pi);
    k2=@(t,s)k_0(t,s).*sin(j*t);
    A(2*j+1,1)=integral2(k2,0,2*pi,0,2*pi)/(sqrt(2)*pi);
end
for j=1:n
    for i=1:n
        k1=@(t,s)k_0(t,s).*cos(i*s).*cos(j*t);
        A(2*j,2*i)=integral2(k1,0,2*pi,0,2*pi)/pi;
        k1=@(t,s)k_0(t,s).*cos(i*s).*sin(j*t);
        A(2*j+1,2*i)=integral2(k1,0,2*pi,0,2*pi)/pi;
        k1=@(t,s)k_0(t,s).*sin(i*s).*cos(j*t);
        A(2*j,2*i+1)=integral2(k1,0,2*pi,0,2*pi)/pi;
        k1=@(t,s)k_0(t,s).*sin(i*s).*sin(j*t);
        A(2*j+1,2*i+1)=integral2(k1,0,2*pi,0,2*pi)/pi;
    end
    k2=@(t)y(t).*cos(j*t);
    Y(2*j,1)=integral(k2,0,2*pi)/sqrt(pi);
    k2=@(t)y(t).*sin(j*t);
    Y(2*j+1,1)=integral(k2,0,2*pi)/sqrt(pi);
end
c=(L-A)\Y;
end

