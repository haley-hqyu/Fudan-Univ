%H11_1
error = 0*[1:6];
for(t = 2:7)
N = 2^t;
n = floor(N-1);
h = 1/N;
x = 0:h:1;
x = x(2:n+1);
y = 0:h:1;
y = y(2:n+1);

exact = @(i,j) x(i)*(1-x(i))*y(j)*(1-y(j))+1;

uexact= 0*(1:n^2);

%Õæ½â
for j=1:n
    for i = 1:n
        uexact(j+(i-1)*n)=exact(i,j);
    end
end

%A

I = speye(n,n);
E = sparse(2:n,1:n-1,1,n,n);
D = E+E'-2*I;
A = -(kron(D,I)+kron(I,D))/h^2;

% f

ff = @(i,j) 2*y(j)*(1-y(j))+2*x(i)*(1-x(i))+x(i)*(1-x(i))*y(j)*(1-y(j))+1;

f = 0*eye(n,n);

for i = 1:n
    for j=1:n
        f(i,j)= ff(i,j);
    end
end

% for j = 1:n
%         f(j)= f(j)+1/h^2;
% end
% for j = 1:n
%         f(j+n*(n-1))= f(j+n*(n-1))+1/h^2;
% end
% 
% 
% for i = 1:n
%         f(1+n*(i-1))= f(1+n*(i-1))+1/h^2;
% end
% for i = 1:n
%         f(n+n*(i-1))= f(n+n*(i-1))+1/h^2;
% end

for i=1:n
    f(1,i)=f(1,i)+1/h^2;
    f(n,i)=f(N-1,i)+1/h^2;
    f(i,1)=f(i,1)+1/h^2;
    f(i,n)=f(i,N-1)+1/h^2;
end
f=reshape(f,n^2,1);

II = eye(n^2);
u = (A+II)\f;
error1(t-1) = norm(u-uexact',2);
error2(t-1) = norm(u-uexact',inf);
end
loglog((1/2).^(2:7),error1)
hold on
loglog((1/2).^(2:7),error2)




