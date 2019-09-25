%Adams
uexact=@(t,lambda,u0) exp(-lambda.*t).*(u0+lambda.*(exp(lambda.*t).*sin(t)+lambda.*exp(lambda.*t).*cos(t)-lambda)./(lambda^2+1));

%µ¼Êý
f=@(u,t,lambda) lambda*(-u+cos(t));
dt=10^(-2);
u(1)=0;
u(2)=uexact(dt,1000,u(1));
u(3)=uexact(2*dt,1000,u(1));
for i=4:ceil(1/dt)+1
    u(i)=u(i-1)+dt/12*(23*f(u(i-1),dt*(i-2),1000)-16*f(u(i-2),dt*(i-3),1000)+5*f(u(i-3),dt*(i-4),1000));
end
% for i=2:ceil(1/dt)+1
%     u(i)=(u(i-1)+1000*cos(dt*(i-1))*dt)/(1+1000*dt);
% end
plot((0:dt:1),u)