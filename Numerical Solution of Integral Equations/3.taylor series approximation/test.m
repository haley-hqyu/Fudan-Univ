%% �ⷽ�̳���
syms t s
%�趨���̵���֪����:���ֺ�kernel=exp(t*s);lambda=5;�Ҷ���y=5*exp(t)-(exp(t+1)-1)/(t+1);��������Ĭ��Ϊ[0,1];taylorչ����n=3��
kernel=exp(t*s);lambda=5;
y=5*exp(t)-(exp(t+1)-1)/(t+1);n=3;
%�õ����̵Ľ�x(t)(��tΪ�����ķ��ź���)
x=solvebytaylor(lambda,kernel,y,n);
%��ֵ������ͼ
t0=linspace(0,1);
yy=eval(subs(x,t,t0));plot(yy);
%% �������� 5*x(t)-int_0^1exp(st)x(s)ds=y(t),��Ϊx(t)=exp(t)
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
legend('չ������3��','չ������5��','չ������7��','��ʵ��',2);
xlabel('t');ylabel('x');
title('��ʵ������ƽ�');
figure(2)
semilogy(t0,e3,'r-',t0,e5,'y-',t0,e7,'g-');
legend('չ������3��','չ������5��','չ������7��',2);
xlabel('t');ylabel('error');
title('�������');