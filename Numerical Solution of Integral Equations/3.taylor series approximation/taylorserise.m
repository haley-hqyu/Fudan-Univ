function tayloroft = taylorserise(fun,n)
%TAYLORSERISE 计算fun的在原点taylor展开
%输入 fun:关于符号变量s,t的符号函数;
%     n:计算至第n-1项;
%输出 tayloroft:[t_0(t),t_1(t),...,t_n-1(t)];
%(taylorofs=[1,s,s^2,...,s^(n-1)])
%by 邹森
syms t s
noftaylor(1)=taylor(fun,[t,s],'order',1);
for i=2:n
    noftaylor(i)=taylor(fun,[t,s],'order',2*i-1)-taylor(fun,[t,s],'order',2*i-2);
end
tayloroft=subs(noftaylor,s,1);
end

