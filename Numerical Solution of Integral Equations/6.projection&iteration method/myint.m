function I = myint(f,a,b)
%MYINT �����
%   �˴���ʾ��ϸ˵��
hh=(b-a)/2;
I=hh*(f(hh*(1-1/sqrt(3))+a)+f(hh*(1+1/sqrt(3))+a));
end

