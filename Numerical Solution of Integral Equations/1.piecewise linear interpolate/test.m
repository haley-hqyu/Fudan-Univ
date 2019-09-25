%% 解方程程序
%初始值的设定
k=@(t,s)t.*s;
y=@(t)(1000-8*pi^3/3)*t;
lambda=1000;
a=0;b=2*pi;n=10;
%得到匿名函数solution
solution=piecewise2(lambda,k,y,a,b,n);
%数值化并画图
x=linspace(a,b,1000);
yy=solution(x);
plot(x,yy);
%% 测试问题一：线性函数 积分核取k(t,s)=t*s,积分区间取[0,2*pi],解函数取u(t)=t
k=@(t,s)t.*s;
y=@(t)(1000-8*pi^3/3)*t;
lambda=1000;
a=0;b=2*pi;
x0=linspace(a,b,1000);y0=x0;%真解
for i=1:6
    n=2^i;
    solution=piecewise2(lambda,k,y,a,b,n);
    h(i)=1/n;
    solvey(i,:)=solution(x0);
    error(i)=max(abs(y0-solvey(i,:)));
end
figure
plot(x0,y0,'r-',x0,solvey(1,:),'b-',x0,solvey(2,:),'g-',x0,solvey(3,:),'y-',x0,solvey(4,:),'c-',x0,solvey(5,:),'m-',x0,solvey(6,:),'k-')
legend('真解','n=2','n=4','n=8','n=16','n=32','n=64',4)
xlabel('t');ylabel('x');
title('真解和对区间做不同划分时的计算解');
figure
plot(h,error,'o')
%% 测试函数二：指数函数 积分核函数取为k(t,s)=exp(t*s),解取为u(t)=exp(t),积分区间为[0,1],lambda=5
k=@(t,s)exp(t.*s);
y=@(t)5*exp(t)-(exp(t+1)-1)/(t+1);
lambda=5;a=0;b=1;
x0=linspace(a,b,1000);y0=exp(x0);%真解
for i=1:6
    n=2^i;
    solution=piecewise2(lambda,k,y,a,b,n);
    h(i)=1/n;
    solvey(i,:)=solution(x0);
    error(i)=max(abs(y0-solvey(i,:)));
end
figure
plot(x0,y0,'r-',x0,solvey(1,:),'b-',x0,solvey(2,:),'g-',x0,solvey(3,:),'y-',x0,solvey(4,:),'c-',x0,solvey(5,:),'m-',x0,solvey(6,:),'k-')
legend('真解','n=2','n=4','n=8','n=16','n=32','n=64',4)
xlabel('t');ylabel('x');
title('真解和对区间做不同划分时的计算解');
figure
plot(h,error,'o')
%% 测试函数三：三角函数 积分核函数取为k(t,s)=sin(t*s),解取为u(t)=sin(t),积分区间为[0,2*pi],lambda=20
k=@(t,s)sin(t.*s);
y=@(t)20*sin(t)-0.5*(sin(2*pi*(t-1))/(t-1)-sin(2*pi*(t+1))/(t+1));
lambda=20;
a=0;b=2*pi;
x0=linspace(a,b,1000);y0=sin(x0);%真解
for i=1:6
    n=2^i;
    solution=piecewise2(lambda,k,y,a,b,n);
    h(i)=1/n;
    solvey(i,:)=solution(x0);
    error(i)=max(abs(y0-solvey(i,:)));
end
figure
plot(x0,y0,'r-',x0,solvey(1,:),'b-',x0,solvey(2,:),'g-',x0,solvey(3,:),'y-',x0,solvey(4,:),'c-',x0,solvey(5,:),'m-',x0,solvey(6,:),'k-')
legend('真解','n=2','n=4','n=8','n=16','n=32','n=64',4)
xlabel('t');ylabel('x');
title('真解和对区间做不同划分时的计算解');
figure
plot(h,error,'o')

