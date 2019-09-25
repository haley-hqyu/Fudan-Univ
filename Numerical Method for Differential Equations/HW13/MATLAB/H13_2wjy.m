u0 = @(x) sin(pi * x);
u = @(t,x) sin(pi .* x) .* exp(-pi .^ 2 .* t);
[X1,X2] = ndgrid(0:.01:1, 0:.01:1);
Z = u(X1,X2);
figure(1); mesh(X1,X2,Z);

%------

dt = 10^-2;
h = 10^-1;
a = 1;
N = 1/h;
T = 1;
tN = T/dt;
theta = 0;
u1 = zeros(tN+1,N-1);
u1(1, : ) = u0((1:N-1)/N);
dx = -1/h^2 * ones(N-1,1);
Delta = spdiags([-dx 2*dx -dx],-1:1,N-1,N-1);
I = speye(N-1,N-1);
for i = 2 : (tN + 1)3
    u1(i, :) = (I  - a * theta * dt * Delta)^(-1) * (I + a * (1-theta) * dt * Delta) * u1(i-1,:)';
end
[T,X] = ndgrid(0:dt:1,0:h:1);
u1 = [zeros(tN+1,1) u1 zeros(tN+1,1)];
figure(2);mesh(T,X,u1)



%%----Richard----
dt = 10^-2;
h = 10^-2;
a = 1;
N = 1/h;
T = 1;
tN = T/dt;
theta = 1/2;
dx = -1/h^2*ones(N-1,1);
Delta = spdiags([-dx 2*dx -dx],-1:1,N-1,N-1);

u1 = zeros(tN+1,N-1);
I = speye(N-1,N-1);
u1(1, : ) = u0((1:N-1)/N);
%u1(2, :) = (I  - a * theta * dt * Delta)^(-1) * (I + a * (1-theta) * dt * Delta) * u1(1,:)';
u1(2,:) = u(dt, (1:N-1)/N);
for i = 3 : (tN + 1)
    u1(i, :) = u1(i-2,:) + (2 * dt * a * Delta * u1(i-1,:)')';
end
[T,X] = ndgrid(0:dt:1,0:h:1);
u1 = [zeros(tN+1,1) u1 zeros(tN +1,1)];
figure(4);mesh(T,X,u1);