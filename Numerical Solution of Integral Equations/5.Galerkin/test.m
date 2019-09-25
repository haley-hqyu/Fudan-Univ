%% 解方程的程序
k=@(t,s)t.*s;
y=@(t)(1000-8*pi^3/3)*t;
lambda=1000;n=3;
x=linspace(0,2*pi,1000);
xi=galerkin(k,y,lambda,n);
yy=plotsolution(xi,x);
plot(x,yy)
%% 测试一：线性函数:积分核函数取为k(t,s)=t*s,解取为u(t)=t,积分区间为[0,2*pi],lambda=1000
k=@(t,s)t.*s;
y=@(t)(1000-8*pi^3/3)*t;
lambda=1000;
x=linspace(0,2*pi,1000);
ytrue=x;
n=[1,2,3,4];
for i=1:length(n);
    xi=galerkin(k,y,lambda,n(i));
    u(i,:)=plotsolution(xi,x);
    h(i)=1/n(i);
    error(i)=max(abs(u(i,:)-ytrue));
end
figure
plot(x,ytrue,'r-',x,u(1,:),'g-',x,u(2,:),'b-',x,u(3,:),'y-',x,u(4,:),'k-');
legend('真解','n=5','n=10','n=15','n=20',4)
xlabel('t');ylabel('u(t)');
figure
plot(h,error,'o-');
%% 测试二：指数函数:积分核函数取为k(t,s)=exp(t*s),解取为u(t)=exp(t),积分区间为[0,2*pi],lambda=20
k=@(t,s)exp(t.*s);
y=@(t)20*exp(t)-(exp(2*pi*(t+1))-1)/(t+1);
lambda=20;
x=linspace(0,2*pi,1000);
ytrue=exp(x);
n=[1,2,3,4];
for i=1:length(n);
    xi=galerkin(k,y,lambda,n(i));
    u(i,:)=plotsolution(xi,x);
    h(i)=1/n(i);
    error(i)=max(abs(u(i,:)-ytrue));
end
figure
plot(x,ytrue,'r-',x,u(1,:),'g-',x,u(2,:),'b-',x,u(3,:),'y-',x,u(4,:),'k-');
axis([0 2*pi -0.5 exp(7)])
legend('真解','n=5','n=10','n=15','n=20',4)
xlabel('t');ylabel('u(t)');
figure
plot(h,error,'o-');
%% 测试三：三角函数:积分核函数取为k(t,s)=sin(t*s),解取为u(t)=sin(t),积分区间为[0,2*pi],lambda=20
k=@(t,s)sin(t.*s);
y=@(t)20*sin(t)-0.5*(sin(2*pi*(t-1))/(t-1)-sin(2*pi*(t+1))/(t+1));
lambda=20;
x=linspace(0,2*pi,1000);
ytrue=sin(x);
n=[1,2,3,4];
for i=1:length(n);
    xi=galerkin(k,y,lambda,n(i));
    u(i,:)=plotsolution(xi,x);
    h(i)=1/n(i);
    error(i)=max(abs(u(i,:)-ytrue));
end
figure
plot(x,ytrue,'r-',x,u(1,:),'g-',x,u(2,:),'b-',x,u(3,:),'y-',x,u(4,:),'k-');
legend('真解','n=5','n=10','n=15','n=20',4)
xlabel('t');ylabel('u(t)');
figure
plot(h,error,'o-');