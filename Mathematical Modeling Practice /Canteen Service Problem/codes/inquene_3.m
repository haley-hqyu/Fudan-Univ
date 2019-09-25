%初步解出排队人数函数
n_1=dsolve('Dy=767*exp(-(t-18.4967)^2/(2*43.9892))/sqrt(2*pi*43.9892)-30','y(12.343323750)=0','t')
%解出分段函数n1
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
title('排队时间 N＝3');xlabel('到达时间／5min');ylabel('排队时间／5min')
mina=min(a)%计算不再需要排队的最小时间

%计算t时刻前往食堂需要排队时间；
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
title('排队时间 N＝3');xlabel('到达时间／5min');ylabel('排队时间／5min')
axis square