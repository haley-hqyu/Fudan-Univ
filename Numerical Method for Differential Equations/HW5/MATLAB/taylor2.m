Ft=@(x) x-x^2;
u(1)=0.5;
ut3(1)=0.5;
ut2(1)=0.5;
for j=1:14
dt=2^(-j);
for i=1:ceil(8/dt)
    u(i+1)=u(i)+dt*Ft(u(i));
end
error1(j)=abs(u(i+1)-1/(exp(-8)+1))

%Taylor q=2

F=@(x) (1-2*x)*(x-x^2);
G=@(x) -2*(x-x.^2)^2;
for i=1:ceil(8/dt)
    ut2(i+1)=ut2(i)+dt*(Ft(ut2(i))+dt*1/2*F(ut2(i)));
   
end
error2(j)=abs(ut2(i+1)-1/(exp(-8)+1)) 

for i=1:ceil(8/dt)
    ut3(i+1)=ut3(i)+dt*(Ft(ut3(i))+dt*1/2*F(ut3(i))+1/6*dt^2*(G(ut3(i))+(1-2*ut3(i))*F(ut3(i))));
  
end
error3(j)=abs(ut3(i+1)-1/(exp(-8)+1))

end
dt=2.^(-(1:14));
loglog(-dt,error1,'-o');
hold on
loglog(-dt,error2,'-bd');
hold on
loglog(-dt,error3,'-*');
axis square
