%����Ŷ���������
n_1=dsolve('Dy=767*exp(-(t-18.4967)^2/(2*43.9892))/sqrt(2*pi*43.9892)-40','y(14.953504)=0','t')
%�Ŷ�����ͼ��
inline=ones(1,331);
a=40.*ones(1,40);
k=0;
for i=1:331;
    t=1+0.1*(i-1);
    inline(i)=subs(n_1);
    if  t<14.953504;
        inline(i)=0;
    end
    if t>14.953504&inline(i)<0;
        k=k+1;
        a(k)=t;
        inline(i)=0;
    end
end
i=1:331;
t=1+0.1.*(i-1);
%plot(t,inline)
%title('�Ŷ�����ͼ�� N��4');xlabel('ʱ�䣯5min');ylabel('��������')
mina=min(a)%���㲻���Ŷӵ���Сʱ��

%����tʱ��ǰ��ʳ����Ҫ�Ŷ�ʱ�䣻
time=ones(1,331);
for i=1:331;
    t=1+0.1.*(i-1);
    if inline(i)>0
        time(i)=subs(n_1)/40;
    else time(i)=0;
    end
end
i=1:331;
t=1+0.1.*(i-1);
plot(t,time)
title('�Ŷ�ʱ�� N��4');xlabel('����ʱ�䣯5min');ylabel('�Ŷ�ʱ�䣯5min')
axis square