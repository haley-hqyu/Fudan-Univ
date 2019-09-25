function I = myint(f,a,b)
%MYINT 求积分
%   此处显示详细说明
hh=(b-a)/2;
I=hh*(f(hh*(1-1/sqrt(3))+a)+f(hh*(1+1/sqrt(3))+a));
end

