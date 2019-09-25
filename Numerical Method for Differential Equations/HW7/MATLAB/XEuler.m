function u=XEuler(lambda,u0,T,dt)
if (nargin<4) u0=1;lambda=1000;T=10;dt=0.001;end
u=[1:2];
u(1)=u0;
df=@(u,t,lambda) lambda*(-u+cos(t));

for i=2:ceil(T/dt)+1
    u(i)=u(i-1)+dt*lambda*(-u(i-1)+cos((i-1)*dt));
end
%plot((0:dt:T),u);