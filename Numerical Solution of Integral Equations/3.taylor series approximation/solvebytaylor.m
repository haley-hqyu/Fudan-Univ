function x = solvebytaylor(lambda,kernel,y,n)
%SOLVEBYTAYLOR ����taylor�������ƽ�ڶ���fredholm���ַ���
%lambda*x(t)-integral_a^b kernel(t,s)*x(s)ds=y(t)
%���� lambda:���̲���lambda;
%     a,b:��������[a,b];
%     kernel:�˺���������t,s�ķ��ź���
%     y:���̵��Ҷ˺���������s�ķ��ź���
%     n:taylorչ������
%��� x:���̵Ľ⣬����t�ķ��ź���
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

