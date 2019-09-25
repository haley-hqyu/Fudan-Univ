%H_2

for i=(3:12)
    N=2^i;
h = 1/N;
a=1;
b=1;
c=1;
A = (diag(2*ones(1,N))-diag(ones(1,N-1),1)-diag(ones(1,N-1),-1))/h^2;
A(N,N)=0;
A(N,N-1)=0;
C = diag((c/a*ones(1,N)));
C(N,N)=0;
B = b/a*(diag(ones(1,N-1),1)-diag(ones(1,N-1),-1))/(2*h);


B(N,N-1)=-2;
B(N,N)=2+2*h+(c-b)/a*h^2;
f = ones(N-1,1)/a;
f(N,1)=h^2/a;
%第三种方法
u3=(A+B+C)^(-1)*f;
%plot((0:h:1-h),u)
%hold on

%第一种方法
B(N,N)=1+h;
B(N,N-1)=-1;
f(N,1)=0;
u1=(A+B+C)^(-1)*f;

%第二种方法
B(N,N)=h+3/2;
B(N,N-1)=-4/2;
B(N,N-2)=1/2;
f(N,1)=0;
u2=(A+B+C)^(-1)*f;

%精确
l1=(b+(b^2+4*a*c)^(1/2))/(2*a);
l2=(b-(b^2+4*a*c)^(1/2))/(2*a);

c1=((l2+1)*exp(l2)-1)/(c*((l1+1)*exp(l1)-(l2+1)*exp(l2)));

f=@(x) c1*exp(l1*x)+(-1/c-c1)*exp(l2*x)+1/c;

xx=(h:h:1);
v=f(xx);
%plot((0:h:1-h),v);

error1(i)=max(abs(v-u1'));
error2(i)=max(abs(v-u2'));
error3(i)=max(abs(v-u3'));
end
semilogy(-(3:12),error1(3:12),'-d');
hold on
semilogy(-(3:12),error2(3:12),'-d');
semilogy(-(3:12),error3(3:12),'-d');
