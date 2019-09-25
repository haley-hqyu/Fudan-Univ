y_arrive=[ 1 5 5 5 8 8 11 9 13 21 26 24 31 39 44 46 53 48 43 40 34 43 30 30 23 25 24 16 20 18 11 7 4 2 ];
x=1:34;
bar(x,y_arrive)
title('北区食堂一楼到达人数柱状图');
xlabel('时间／5min')
ylabel('人数／个')
hold on

mean_x=sum(x.*y_arrive)/sum(y_arrive)
var_x=sum((x-mean_x).^2.*y_arrive)/sum(y_arrive)
%画出按照正态分布每时刻到达人数图像a
a=1:0.01:34;
pdf_a=sum(y_arrive).*exp(-(a-mean_x).^2/(2*var_x))/sqrt(2*pi*var_x);
plot(a,pdf_a,'r');title('北区一楼食堂到达人数正态分布图');xlabel('时间／5min');ylabel('人数／个')

%画出按照正态分布每五分钟到达人数图像b
b=1:34;
pdf_b=sum(y_arrive).*exp(-(b-mean_x).^2/(2*var_x))/sqrt(2*pi*var_x);
%bar(b,pdf_b);
axis square
%求出正态分布各参数
SSE=sum(x.*(pdf_b-y_arrive).^2);
MSE=SSE/34;
RMSE=sqrt(MSE);
t=[1020:5:1055 1100:5:1155 1200:5:1255 1300:5:1305];