function y = plotsolution(c,x0)
%PLOTSOLUTION �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
n=round((length(c)-1)/2);
y=c(1)/sqrt(2*pi)*ones(size(x0));
for i=1:n
    y=y+c(2*i)*cos(i*x0)/sqrt(pi)+c(2*i+1)*sin(i*x0)/sqrt(pi);
end
end

