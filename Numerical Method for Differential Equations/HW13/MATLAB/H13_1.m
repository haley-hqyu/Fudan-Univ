%H13_1

X = 1;
T = 1;

%精确解
exact = @(t,x) sin(pi*x)*exp(-pi^2*t);

for jj = 1:7

dx = 10^-2;
dt = 2^(-jj);
t = 0:dt:T;
x = 0:dx:X;
Nx = length(x);
Nt = length(t);

for i=1:Nx
    for j=1:Nt
        uexact(j,i)=exact(t(j),x(i));
    end
end



%生成初值
u0 = sin(pi.*x);



%theta;

%generate deltah

N = Nx-2;
xx = ones(N,1);
delta = spdiags([xx,-2*xx,xx],-1:1,N,N)./(dx^2);
I = speye(N,N);
a = 1;
theta = 1;

uxian = zeros(Nt,N);
uxian(1,:) = u0(2:N+1);
for tt=2:Nt
    uxian(tt,:) = ((I-a*dt*theta*delta)^(-1))*(I+a*dt*(1-theta)*delta)*uxian(tt-1,:)';
end

uuxian = [zeros(Nt,1) uxian zeros(Nt,1)];

error = zeros(Nt,1);



% for tt=1:Nt
%     error(tt) = norm(uuxian(tt,:)-uexact(tt,:));
% end

errornorm(jj) = norm(uuxian-uexact);

% for i=1:10
%     plot(uxian(i,:))
%     hold on
% end

u1 = zeros(Nt,N);
I = speye(N,N);
u1(1, : ) = u0(2:N+1);

for i=1:N
    for j=2
        u1(j,i)=exact(t(j),x(i));
    end
end

for i = 3 : Nt
    u1(i, :) = u1(i-2,:) + (2 * dt * a * delta * u1(i-1,:)')';
end

uur = [zeros(Nt,1) u1 zeros(Nt,1)];

error = zeros(Nt,1);



% for tt=1:Nt
%     error(tt) = norm(uuxian(tt,:)-uexact(tt,:));
% end

errornorm2(jj) = norm(uur-uexact);


end
%[x,y]=meshgrid(x,t);

%surf(x,y,uexact);
%hold on 
%mesh(x,y,uuxian);
