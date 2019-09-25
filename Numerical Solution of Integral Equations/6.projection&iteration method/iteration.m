function u = iteration(k,y,lambda,x,x1,x2,t0)
%iteration 迭代
%input:k:积分核
%      y:右端函数
%      lambda:\lambda
%      xi:帽子函数的系数向量
%      [a,b]:积分区间
%      t0
%output:u:数值解在t0上的取值
n=length(x);
t=linspace(x1,x2,n);
h=(x2-x1)/(n-1);
m=length(t0);
u=zeros(size(t0));
for i=1:m
    knew1=@(s)k(t0(i),s)*(t(2)-s)/h;
    u(i)=u(i)+x(1)*(myint(knew1,t(1),t(2)));
    for j=2:n-1
        knew1=@(s)k(t0(i),s)*(s-t(j-1))/h;
        knew2=@(s)k(t0(i),s)*(t(j+1)-s)/h;
        u(i)=u(i)+x(j)*(myint(knew1,t(j-1),t(j))+myint(knew2,t(j),t(j+1)));
    end
    knew1=@(s)k(t0(i),s)*(s-t(n))/h;
    u(i)=u(i)+x(n)*(myint(knew1,t(n-1),t(n)));
end
u=(y(t0)+u)/lambda;
end

