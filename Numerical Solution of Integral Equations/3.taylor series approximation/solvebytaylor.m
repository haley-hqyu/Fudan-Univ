function x = solvebytaylor(lambda,kernel,y,n)
%SOLVEBYTAYLOR 利用taylor级数近似解第二类fredholm积分方程
%lambda*x(t)-integral_a^b kernel(t,s)*x(s)ds=y(t)
%输入 lambda:方程参数lambda;
%     a,b:积分区间[a,b];
%     kernel:核函数，关于t,s的符号函数
%     y:方程的右端函数，关于s的符号函数
%     n:taylor展开次数
%输出 x:方程的解，关于t的符号函数
syms t s
tayloroft=taylorserise(kernel,n);
Lambda=lambda*eye(n);
for i=1:n
    for j=1:n
        T(i,j)=eval(int(tayloroft(j)*t.^(i-1),0,1));
    end
    Y(i,1)=eval(int(y*t.^(i-1),0,1));
end
X=(Lambda-T)\Y;
x=(tayloroft*X+y)/lambda;
end

