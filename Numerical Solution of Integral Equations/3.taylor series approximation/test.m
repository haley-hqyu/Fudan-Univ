%% 解方程程序
syms t s
%设定方程的已知条件:积分核kernel=exp(t*s);lambda=5;右端项y=5*exp(t)-(exp(t+1)-1)/(t+1);积分区间默认为[0,1];taylor展开至n=3项
kernel=exp(t*s);lambda=5;
y=5*exp(t)-(exp(t+1)-1)/(t+1);n=3;
%得到方程的解x(t)(以t为变量的符号函数)
x=solvebytaylor(lambda,kernel,y,n);
%数值化并绘图
t0=linspace(0,1);
yy=eval(subs(x,t,t0));plot(yy);
%% 测试问题 5*x(t)-int_0^1exp(st)x(s)ds=y(t),解为x(t)=exp(t)
syms t s
kernel=exp(t*s);
y=5*exp(t)-(exp(t+1)-1)/(t+1);
x3=solvebytaylor(5,kernel,y,3);
x5=solvebytaylor(5,kernel,y,5);
x7=solvebytaylor(5,kernel,y,7);
t0=linspace(0,1);
y3=eval(subs(x3,t,t0));y5=eval(subs(x5,t,t0));y7=eval(subs(x7,t,t0));
y0=exp(t0);
e3=abs(y3-y0);e5=abs(y5-y0);e7=abs(y7-y0);
figure(1)
plot(t0,y3,'r-',t0,y5,'y-',t0,y7,'g-',t0,y0,'b-');
legend('展开至第3项','展开至第5项','展开至第7项','真实解',2);
xlabel('t');ylabel('x');
title('真实解与近似解');
figure(2)
semilogy(t0,e3,'r-',t0,e5,'y-',t0,e7,'g-');
legend('展开至第3项','展开至第5项','展开至第7项',2);
xlabel('t');ylabel('error');
title('绝对误差');