%收敛阶
Ft=@(x) x-x^2;
F=@(t) 1/(exp(-t)+1);
u1(1)=0.5;u(1)=0.5
u2(1)=0.5;;
u3(1)=0.5;
for j=1:14
    dt=2^(-j);
    
    for i=1:ceil(1/dt)
    u(i+1)=u(i)+dt*Ft(u(i));
    end
 error0(j)=abs(u(i+1)-F(1))/abs(F(1));
    %修正的Euler方法2
    for i=1:ceil(1/dt)
        u1(i+1)=u1(i)+dt*Ft(u1(i)+dt/2*Ft(u1(i)));
        %error11(i)=abs(u1(i)-F((i-1)*dt))/abs(F((i-1)*dt));
    end
    error1(j)=abs(u1(i+1)-F(1))/abs(F(1));
    %3
    for i=1:ceil(1/dt)
        k1=Ft(u2(i));
        k2=Ft(u2(i)+dt/2*k1);
        k3=Ft(u2(i)-dt*k1+2*dt*k2);
        u2(i+1)=u2(i)+dt/6*(k1+4*k2+k3);
       % error22(i)=abs(u2(i)-F((i-1)*dt))/abs(F((i-1)*dt));
    end
    error2(j)=abs(u2(i+1)-F(1))/abs(F(1));

    %4
    for i=1:ceil(1/dt)
        k1=Ft(u3(i));
        k2=Ft(u3(i)+1/2*dt*k1);
        k3=Ft(u3(i)+1/2*dt*k2);
        k4=Ft(u3(i)+dt*k3);
        u3(i+1)=u3(i)+dt/6*(k1+2*k2+2*k3+k4);
        %error33(i)=abs(u3(i)-F((i-1)*dt))/abs(F((i-1)*dt));
    end
    error3(j)=abs(u3(i+1)-F(1))/abs(F(1));
end
dt=2.^(-(1:14));
loglog(-dt,error0,'-<');
hold on
loglog(-dt,error1,'-d');
hold on
loglog(-dt,error2,'-*');
hold on
loglog(-dt,error3,'-o');
        axis square

        
    
