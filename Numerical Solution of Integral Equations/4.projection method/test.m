%% �ⷽ�̵ĳ���
k=@(t,s)t.*s;
y=@(t)(1000-8*pi^3/3)*t;
lambda=1000;a=0;b=2*pi;
x=linspace(0,2*pi,1000);n=10;
xi=projection(k,y,lambda,a,b,n);
yy=plotsolution(xi,x);
figure
plot(x,yy)
%% ����һ�����Ժ���:���ֺ˺���ȡΪk(t,s)=t*s,��ȡΪu(t)=t,��������Ϊ[0,2*pi],lambda=1000
k=@(t,s)t.*s;
y=@(t)(1000-8*pi^3/3)*t;
lambda=1000;a=0;b=2*pi;
x=linspace(0,2*pi,1000);
ytrue=x;
n=[5,10,15,20];
for i=1:length(n);
    xi=projection(k,y,lambda,a,b,n(i));
    u(i,:)=plotsolution(xi,x);
    h(i)=1/n(i);
    error(i)=max(abs(u(i,:)-ytrue));
end
figure
plot(x,ytrue,'r-',x,u(1,:),'g-',x,u(2,:),'b-',x,u(3,:),'y-',x,u(4,:),'k-');
legend('���','n=5','n=10','n=15','n=20',4)
xlabel('t');ylabel('u(t)');
figure
loglog(h,error,'o-');
%% ���Զ���ָ������:���ֺ˺���ȡΪk(t,s)=exp(t*s),��ȡΪu(t)=exp(t),��������Ϊ[0,1],lambda=5
k=@(t,s)exp(t.*s);
y=@(t)5*exp(t)-(exp(t+1)-1)/(t+1);
lambda=5;a=0;b=1;
x=linspace(a,b,1000);
ytrue=exp(x);
n=[5,10,15,20];
for i=1:length(n);
    xi=projection(k,y,lambda,a,b,n(i));
    u(i,:)=plotsolution(xi,x);
    h(i)=1/n(i);
    error(i)=max(abs(u(i,:)-ytrue));
end
figure
plot(x,ytrue,'r-',x,u(1,:),'g-',x,u(2,:),'b-',x,u(3,:),'y-',x,u(4,:),'k-');
legend('���','n=5','n=10','n=15','n=20',4)
xlabel('t');ylabel('u(t)');
figure
plot(h,error,'o-');
%% �����������Ǻ���:���ֺ˺���ȡΪk(t,s)=sin(t*s),��ȡΪu(t)=t,��������Ϊ[0.5,2*pi],lambda=5
k=@(t,s)sin(t.*s);
y=@(t)5*t-(0.5*cos(0.5*t)-2*pi*cos(2*pi*t))./t-(sin(2*pi*t)-sin(t/2))./t.^2;
lambda=5;a=0.5;b=2*pi;
x=linspace(a,b,1000);
ytrue=sin(x);
n=[5,10,15,20];
for i=1:length(n);
    xi=projection(k,y,lambda,a,b,n(i));
    u(i,:)=plotsolution(xi,x);
    h(i)=1/n(i);
    error(i)=max(abs(u(i,:)-ytrue));
end
figure
plot(x,ytrue,'r-',x,u(1,:),'g-',x,u(2,:),'b-',x,u(3,:),'y-',x,u(4,:),'k-');
legend('���','n=5','n=10','n=15','n=20',4)
xlabel('t');ylabel('u(t)');
figure
plot(h,error,'o-');