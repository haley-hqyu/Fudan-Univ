function xi= projection(k,y,lambda,a,b,n)
%PROJECTION ���÷� ������ȡΪñ�Ӻ���
%input:k:���ֺ�
%      y:�Ҷ���
%      lambda:\lambda
%      [a,b]:��������
%      n:ͶӰ�ռ�ά��
%output:xi:ñ�Ӻ���ǰ��ϵ��
h=(b-a)/(n-1);
ti=linspace(a,b,n);
Lambda=lambda*eye(n);
A=zeros(n,n);
Y=y(ti);Y=Y';
for j=1:n
    k1=@(s)k(ti(j),s).*(ti(2)-s)/h;
    A(j,1)=quad(k1,ti(1),ti(2));
    for i=2:n-1
        k1=@(s)k(ti(j),s).*(s-ti(i-1))/h;
        k2=@(s)k(ti(j),s).*(ti(i+1)-s)/h;
        A(j,i)=quad(k1,ti(i-1),ti(i))+quad(k2,ti(i),ti(i+1));
    end
    k1=@(s)k(ti(n),s).*(s-ti(n-1))/h;
    A(j,n)=quad(k1,ti(n-1),ti(n));
end
xi=(Lambda-A)\Y;
end

