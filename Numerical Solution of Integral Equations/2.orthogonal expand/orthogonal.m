function c = orthogonal(k,y,lambda,n)
%ORTHOGONAL 正交逼近退化核方法(三角函数)(为简单起见积分区间取作[0,2*pi],对于一
%般的情况[a,b],作变量替换x=a+(b-a)*t/(2*pi))
%input k:积分核
%      y:右端函数
%      lambda:\lambda
%      n:展开至第2*n+1项
Lambda=lambda*eye(2*n+1);
A=zeros(2*n+1,2*n+1);B=zeros(2*n+1,1);
A(1,1)=integral2(k,0,2*pi,0,2*pi)/(2*pi);
k1=@(t,s)k(t,s).*y(t);
B(1,1)=integral2(k1,0,2*pi,0,2*pi)/sqrt(2*pi);
for i=1:n
    k1=@(t,s)k(t,s).*cos(i*s);
    A(2*i,1)=integral2(k1,0,2*pi,0,2*pi)/(sqrt(2)*pi);
    k2=@(t,s)k(t,s).*sin(i*s);
    A(2*i+1,1)=integral2(k2,0,2*pi,0,2*pi)/(sqrt(2)*pi);
    k3=@(t,s)k(t,s).*cos(i*t);
    A(1,2*i)=integral2(k3,0,2*pi,0,2*pi)/(sqrt(2)*pi);
    k4=@(t,s)k(t,s).*sin(i*t);
    A(1,2*i+1)=integral2(k4,0,2*pi,0,2*pi)/(sqrt(2)*pi);
end
for i=1:n
    for j=1:n
        k1=@(t,s)k(t,s).*cos(i*t).*cos(j*s);
        A(2*i,2*j)=integral2(k1,0,2*pi,0,2*pi)/pi;
        k2=@(t,s)k(t,s).*sin(i*s).*cos(j*t);
        A(2*i+1,2*j)=integral2(k2,0,2*pi,0,2*pi)/pi;
        k3=@(t,s)k(t,s).*sin(j*t).*cos(i*s);
        A(2*i,2*j+1)=integral2(k3,0,2*pi,0,2*pi)/pi;
        k4=@(t,s)k(t,s).*sin(i*s).*sin(j*t);
        A(2*i+1,2*j+1)=integral2(k4,0,2*pi,0,2*pi)/pi;
    end
    k1=@(t,s)k(t,s).*cos(i*s).*y(t);
    B(2*i,1)=integral2(k1,0,2*pi,0,2*pi)/sqrt(pi);
    k2=@(t,s)k(t,s).*sin(i*s).*y(t);
    B(2*i+1,1)=integral2(k2,0,2*pi,0,2*pi)/sqrt(pi);
end
c=(Lambda-A)\B;
end

