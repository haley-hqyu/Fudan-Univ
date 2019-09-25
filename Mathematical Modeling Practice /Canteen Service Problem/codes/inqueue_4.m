%解出排队人数函数
n_1=dsolve('Dy=767*exp(-(t-18.4967)^2/(2*43.9892))/sqrt(2*pi*43.9892)-40','y(14.953504)=0','t')
%排队人数图像
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
%title('排队人数图像 N＝4');xlabel('时间／5min');ylabel('人数／个')
mina=min(a)%计算不再排队的最小时间

%计算t时刻前往食堂需要排队时间；
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
title('排队时间 N＝4');xlabel('到达时间／5min');ylabel('排队时间／5min')
axis square