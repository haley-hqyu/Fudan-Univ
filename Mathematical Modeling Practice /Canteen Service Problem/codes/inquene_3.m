%��������Ŷ���������
n_1=dsolve('Dy=767*exp(-(t-18.4967)^2/(2*43.9892))/sqrt(2*pi*43.9892)-30','y(12.343323750)=0','t')
%����ֶκ���n1
inline=ones(1,331);
a=40.*ones(1,40);
k=0;
for i=1:331;
    t=1+0.1*(i-1);
    inline(i)=subs(n_1);
    if  t<12.343323750;
        inline(i)=0;
    end
    if t>12.343323750&inline(i)<0;
        k=k+1;
        a(k)=t;
        inline(i)=0;
    end
end
i=1:331;
t=1+0.1.*(i-1);
plot(t,inline)
title('�Ŷ�ʱ�� N��3');xlabel('����ʱ�䣯5min');ylabel('�Ŷ�ʱ�䣯5min')
mina=min(a)%���㲻����Ҫ�Ŷӵ���Сʱ��

%����tʱ��ǰ��ʳ����Ҫ�Ŷ�ʱ�䣻
time=ones(1,331);
for i=1:331;
    t=1+0.1.*(i-1);
    if inline(i)>0
        time(i)=subs(n_1)/30;
    else time(i)=0;
    end
end
i=1:331;
t=1+0.1.*(i-1);
plot(t,time)
title('�Ŷ�ʱ�� N��3');xlabel('����ʱ�䣯5min');ylabel('�Ŷ�ʱ�䣯5min')
axis square