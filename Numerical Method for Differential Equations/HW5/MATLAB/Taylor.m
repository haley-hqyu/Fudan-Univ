%第五周作业
Ft=@(x) x-x.^2;
dt=8/50;
u01=0.5;
u02=1.5;
u(1,1)=0.5+dt*Ft(0.5);
ut3(1,1)=0.5+dt*Ft(0.5);
ut2(1,1)=0.5+dt*Ft(0.5);
u(1,2)=1.5+dt*Ft(1.5);
ut2(1,2)=1.5+dt*Ft(1.5);
ut3(1,2)=1.5+dt*Ft(1.5);

%显式欧拉
for i=2:50
    u(i,1)=u(i-1,1)+dt*Ft(u(i-1,1));
    u(i,2)=u(i-1,2)+dt*Ft(u(i-1,2));
end



%Taylor q=2
F=@(x) (1-2*x)*(x-x^2);
G=@(x) -2*(x-x.^2)^2;
for i=2:50
    ut2(i,1)=ut2(i-1,1)+dt*(Ft(ut2(i-1,1))+dt*1/2*F(ut2(i-1,1)));
    ut2(i,2)=ut2(i-1,2)+dt*(Ft(ut2(i-1,2))+dt*1/2*F(ut2(i-1,2)));
end

%q=3
for i=2:50
    ut3(i,1)=ut3(i-1,1)+dt*(Ft(ut3(i-1,1))+dt*1/2*F(ut3(i-1,1))+1/6*dt^2*(G(ut3(i-1,1))+(1-2*ut3(i-1,1))*F(ut3(i-1,1))));
    ut3(i,2)=ut3(i-1,2)+dt*(Ft(ut3(i-1,2))+dt*1/2*F(ut3(i-1,2))+1/6*dt^2*(G(ut3(i-1,2))+(1-2*ut3(i-1,2))*F(ut3(i-1,2))));
end
plot(u(:,1),'ro');
hold on
plot(u(:,2),'bd');


%精确值
t=(0:8/50:8);
F1=1./((2-1).*exp(-t)+1);
F2=1./((1/1.5-1).*exp(-t)+1);
hold on
plot(t*50/8,F1,'k');
hold on
plot(t*50/8,F2,'k');
hold on
plot(0,u01,'ro');
hold on
plot(0,u02,'bd');
set(gca,'xticklabel',[]);

