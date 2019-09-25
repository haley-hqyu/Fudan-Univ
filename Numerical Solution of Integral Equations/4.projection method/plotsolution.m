function y = plotsolution(x,xx)
%PLOTSOLUTION 输入帽子函数前的系数，得到其在x0上的取值
%input:xi:帽子函数的系数
%      x:用于绘图的自变量向量
%output:y:帽子函数在x上的取值向量
n=length(x);
a=length(xx);
x0=linspace(xx(1),xx(a),n);
h=(xx(a)-xx(1))/(n-1);
for j=1:n-1
    index=find(xx>=x0(j)&xx<=x0(j+1));
    y(index)=x(j)*(x0(j+1)-xx(index))/h+x(j+1)*(xx(index)-x0(j))/h;
end
end

