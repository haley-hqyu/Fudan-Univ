%% 解方程的程序
k=@(t,s)t.*s;
y=@(t)(1000-8*pi^3/3)*t;
lambda=1000;a=0;b=2*pi;
x=linspace(0,2*pi,100);n=10;
xi=projection(k,y,lambda,a,b,n);
yy=iteration(k,y,lambda,xi,a,b,x);
figure
plot(x,yy)
%% 测试一：线性函数:积分核函数取为k(t,s)=t*s,解取为u(t)=t,积分区间为[0,2*pi],lambda=1000
k=@(t,s)t.*s;
y=@(t)(1000-8*pi^3/3)*t;
lambda=1000;a=0;b=2*pi;
x=linspace(0,2*pi,100);
utrue=x;
n=[5,10,15,20];
for i=1:length(n)
    xi=projection(k,y,lambda,a,b,n(i));
    u(i,:)=iteration(k,y,lambda,xi,a,b,x);
end
figure
plot(x,utrue,'r-',x,u(1,:),'g-',x,u(2,:),'b-',x,u(3,:),'y-',x,u(4,:),'k-');
legend('真解','n=5','n=10','n=15','n=20',4)
xlabel('t');ylabel('u(t)');
%% 测试二：指数函数:积分核函数取为k(t,s)=exp(t*s),解取为u(t)=exp(t),积分区间为[0,1],lambda=5
k=@(t,s)exp(t.*s);
y=@(t)5*exp(t)-(exp(t+1)-1)/(t+1);
lambda=5;a=0;b=1;
x=linspace(a,b,100);
utrue=exp(x);
n=[5,10,15,20];
for i=1:length(n)
    xi=projection(k,y,lambda,a,b,n(i));
    u(i,:)=iteration(k,y,lambda,xi,a,b,x);
end
figure
plot(x,utrue,'r-',x,u(1,:),'g-',x,u(2,:),'b-',x,u(3,:),'y-',x,u(4,:),'k-');
legend('真解','n=5','n=10','n=15','n=20',4)
xlabel('t');ylabel('u(t)');
%% 测试三：三角函数:积分核函数取为k(t,s)=sin(t*s),解取为u(t)=t,积分区间为[0.5,2*pi],lambda=5
k=@(t,s)sin(t.*s);
y=@(t)5*t-(0.5*cos(0.5*t)-2*pi*cos(2*pi*t))./t-(sin(2*pi*t)-sin(t/2))./t.^2;
lambda=5;a=0.5;b=2*pi;
x=linspace(a,b,100);
utrue=x;
n=[5,10,15,20];
for i=1:length(n)
    xi=projection(k,y,lambda,a,b,n(i));
    u(i,:)=iteration(k,y,lambda,xi,a,b,x);
end
figure
plot(x,utrue,'r-',x,u(1,:),'g-',x,u(2,:),'b-',x,u(3,:),'y-',x,u(4,:),'k-');
legend('真解','n=5','n=10','n=15','n=20',4)
xlabel('t');ylabel('u(t)');