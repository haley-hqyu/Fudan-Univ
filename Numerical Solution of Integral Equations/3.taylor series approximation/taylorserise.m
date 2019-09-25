function tayloroft = taylorserise(fun,n)
%TAYLORSERISE ����fun����ԭ��taylorչ��
%���� fun:���ڷ��ű���s,t�ķ��ź���;
%     n:��������n-1��;
%��� tayloroft:[t_0(t),t_1(t),...,t_n-1(t)];
%(taylorofs=[1,s,s^2,...,s^(n-1)])
%by ��ɭ
syms t s
noftaylor(1)=taylor(fun,[t,s],'order',1);
for i=2:n
    noftaylor(i)=taylor(fun,[t,s],'order',2*i-1)-taylor(fun,[t,s],'order',2*i-2);
end
tayloroft=subs(noftaylor,s,1);
end

