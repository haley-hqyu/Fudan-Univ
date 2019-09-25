function x= projection(k_0,y,lambda,x1,x2,n)
%PROJECTION ���÷� ������ȡΪñ�Ӻ���
%input:k:���ֺ�
%      y:�Ҷ���
%      lambda:\lambda
%      [a,b]:��������
%      n:ͶӰ�ռ�ά��
%output:xi:ñ�Ӻ���ǰ��ϵ��
h=(x2-x1)/(n-1);
xx=linspace(x1,x2,n);
L=lambda*eye(n);
A=zeros(n,n);
Y=y(xx);Y=Y';
for j=1:n
    k1=@(s)k_0(xx(j),s).*(xx(2)-s)/h;
    A(j,1)=quad(k1,xx(1),xx(2));
    for i=2:n-1
        k1=@(s)k_0(xx(j),s).*(s-xx(i-1))/h;
        k2=@(s)k_0(xx(j),s).*(xx(i+1)-s)/h;
        A(j,i)=quad(k1,xx(i-1),xx(i))+quad(k2,xx(i),xx(i+1));
    end
    k1=@(s)k_0(xx(n),s).*(s-xx(n-1))/h;
    A(j,n)=quad(k1,xx(n-1),xx(n));
end
x=(L-A)\Y;
end

