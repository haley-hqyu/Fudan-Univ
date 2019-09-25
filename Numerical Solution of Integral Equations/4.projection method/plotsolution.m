function y = plotsolution(x,xx)
%PLOTSOLUTION ����ñ�Ӻ���ǰ��ϵ�����õ�����x0�ϵ�ȡֵ
%input:xi:ñ�Ӻ�����ϵ��
%      x:���ڻ�ͼ���Ա�������
%output:y:ñ�Ӻ�����x�ϵ�ȡֵ����
n=length(x);
a=length(xx);
x0=linspace(xx(1),xx(a),n);
h=(xx(a)-xx(1))/(n-1);
for j=1:n-1
    index=find(xx>=x0(j)&xx<=x0(j+1));
    y(index)=x(j)*(x0(j+1)-xx(index))/h+x(j+1)*(xx(index)-x0(j))/h;
end
end

