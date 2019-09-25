
X = 1;
T = 1/10;

%精确解
exact = @(t,x) sin(pi*x)*exp(-pi^2*t);
dx = 10^-2;
dt = 10^-2;
t = 0:dt:T;
x = 0:dx:X;
Nx = length(x);
Nt = length(t);

for i=1:Nx
    for j=1:Nt
        uexact(j,i)=exact(t(j),x(i));
    end
end

%精确解
% for i=1:N
%     plot(uexact(i,:))
%     hold on
% end

%生成初值
u0 = sin(pi.*x);

%laplace = @(j,x) ;
%f = @(t,x) 0;


%theta=0;

uxian(1,:)=u0;
errorxian(1)= norm(uxian(1,2:Nx)-uexact(1,2:Nx));

for j=2:Nt
    for i= 2:(Nx-1)
        uxian(j,i) = uxian(j-1,i)+dt/dx^2*(uxian(j-1,i+1)-2*uxian(j-1,i)+uxian(j-1,i-1));       
    end
    errorxian(j)= norm(uxian(j,2:(Nx-1))-uexact(j,2:(Nx-1)));
end

% for i=1:10
%     plot(uxian(i,:))
%     hold on
% end


%theta=1;

uyin(1,:)=u0;
erroryin(1)= norm(uyin(1,2:(Nx-1))-uexact(1,2:(Nx-1)));

for j=2:(Nt)
    for i= 2:(Nx-1)
        uyin(j,i) = dt*laplace(dt*j,x(i))+uyin(j-1,i);
    end
    erroryin(j)= norm(uyin(j,:)-uexact(j,:));
end

% for i=1:10
%     plot(uyin(i,:))
%     hold on
% end

%theta=1/2;

uc(1,:)=u0;
errorc(1)= norm(uc(1,:)-uexact(1,:));

for j=2:(Nt)
    for i= 1:(Nx)
        uc(j,i) = uc(j-1,i)+dt*1/2*(laplace(dt*j,x(i))+laplace(dt*(j-1),x(i)));
    end
     errorc(j)= norm(uc(j,:)-uexact(j,:));
end


%richardison
ur(1,:)=u0;
errorc(1)= norm(ur(1,:)-uexact(1,:));
for j=2:(Nt)
    for i= 1:(Nx)
        uc(j,i) = uc(j-1,i)+dt*1/2*(laplace(dt*j,x(i))+laplace(dt*(j-1),x(i)));
    end
     errorc(j)= norm(uc(j,:)-uexact(j,:));
end



% for i=1
%     plot(uc(i,:))
%     hold on
% end


% tt = (0:(Nx-1))*dt;
% for i=1:Nx 
%     plot3(x,(tt(i)*x),uexact(i,:));
%     hold on
% end

[x,y]=meshgrid(x(2:(Nx-1)),t);

%surf(x,y,uexact);
%hold on 
mesh(x,y,uxian(:,2:(Nx-1)));
