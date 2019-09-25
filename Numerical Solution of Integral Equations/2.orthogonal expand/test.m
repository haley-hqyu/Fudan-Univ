%% �ⷽ�̵ĳ���
%���̵���֪����
k=@(t,s)t.*s;
y=@(t)(1000-8*pi^3/3)*t;
lambda=1000;n=3;
%cΪ��������ϵ������
c=orthogonal(k,y,lambda,3);
%��ֵ������ͼ
x=linspace(0,2*pi,100);
yy=plotsolution(c,y,x,lambda);
figure
plot(x,yy);
%% ����һ�����Ժ���:���ֺ˺���ȡΪk(t,s)=t*s,��ȡΪu(t)=t,��������Ϊ[0,2*pi],lambda=1000
k=@(t,s)t.*s;
y=@(t)(1000-8*pi^3/3)*t;
lambda=1000;n=[1,2,3,4];
x=linspace(0,2*pi,50);
value=zeros(4,50);
for i=1:length(n)
    c=orthogonal(k,y,lambda,n(i));
    value(i,:)=plotsolution(c,y,x,lambda);
    error(i)=max(abs(x-value(i,:)));
end
figure
plot(x,x,'b-',x,value(1,:),'r-',x,value(2,:),'g-',x,value(3,:),'y-',x,value(4,:),'k-')
figure
plot(error,'o-')
%% ���Զ���ָ������:���ֺ˺���ȡΪk(t,s)=exp(t*s),��ȡΪu(t)=exp(t),��������Ϊ[0,2*pi],lambda=1000
k=@(t,s)exp(t.*s);
y=@(t)1000*exp(t)-(exp(2*pi*(t+1))-1)./(t+1);
lambda=1000;n=[1,2,3,4];
x=linspace(0,2*pi,50);
yy=exp(x);
value=zeros(4,50);
for i=1:length(n)
    c=orthogonal(k,y,lambda,n(i));
    value(i,:)=plotsolution(c,y,x,lambda);
    error(i)=max(abs(yy-value(i,:)));
end
figure
plot(x,yy,'b-',x,value(1,:),'r-',x,value(2,:),'g-',x,value(3,:),'y-',x,value(4,:),'k-')
axis([0 2*pi -100 600])
figure
plot(error,'o-')
%% �����������Ǻ���:���ֺ˺���ȡΪk(t,s)=sin(t*s),��ȡΪu(t)=sin(t),��������Ϊ[0,2*pi],lambda=20
k=@(t,s)sin(t.*s);
y=@(t)20*sin(t)-0.5*(sin(2*pi*(t-1))./(t-1)-sin(2*pi*(t+1))./(t+1));
lambda=20;n=[1,2,3,4];
x=linspace(0,2*pi,50);
yy=sin(x);
value=zeros(4,50);
for i=1:length(n)
    c=orthogonal(k,y,lambda,n(i));
    value(i,:)=plotsolution(c,y,x,lambda);
    error(i)=max(abs(yy-value(i,:)));
end
figure
plot(x,yy,'b-',x,value(1,:),'r-',x,value(2,:),'g-',x,value(3,:),'y-',x,value(4,:),'k-')
figure
plot(error,'o-')