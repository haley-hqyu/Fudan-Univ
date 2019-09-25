%

%dt+du=0;
%u分段

%设置初值等

clear all
%for kk=4:10

T=1;
X=2;
N=100;
h=X/N;
tau=h/2;
Ni=X/h;
Nn=T/tau;

x=0:h:X;%length x =N+1;
t=0:tau:T;%length t =N+1;

r=tau/h;
%真实解

uexact = @(x,t) 1.*(x>(1/4+t)).*(x<(3/4+t));
%uexact = @(x,t) 4*(x-1/4).*(x>(1/4+t)).*(x<=(1/2+t))+4*(3/4-x).*(x>(1/2+t)).*(x<(3/4+t));

uexactt = zeros(Nn+1,Ni+1);
uexactt(1,:)=uexact(x,0);
for n=1:Nn+1
    uexactt(n,:)=uexact(x,t(n));
end




%迎风格式 u(n+1,i)=(1-r)u(n,i)+ru(n,i-1);
% i from 0 to N;
% n from 0 to N;uy(n,i);

uy = zeros(Nn+1,Ni+1);
uy(1,:)=uexactt(1,:);

for n=1:Nn
    for i=2:Ni
        uy((n+1),i)=(1-r)*uy(n,i)+r*uy(n,i-1);
    end
    %errory(n)=norm(uy((n+1),:)-uexactt((n+1),:))/norm(uexactt((n+1),:));
end
%erroryy(kk)=norm((uy(end,:)-uexactt(end,:)));

%mesh(uy);

%Lax格式
ulax = zeros(Nn+1,Ni+1);
ulax(1,:)=uexactt(1,:);

for n=1:Nn
     for i=2:Ni
        ulax((n+1),i)=(1-r)*ulax(n,i+1)/2+(1+r)*ulax(n,i-1)/2;
     end
    %errorlax(n)=norm(ulax((n+1),:)-uexactt((n+1),:))/norm(uexactt((n+1),:));
end
%errorll(kk)=max((ulax(end,:)-uexactt(end,:)));


%lax-wendroff

%e=h^2/2/tau;

ulw = zeros(Nn+1,Ni+1);
ulw(1,:)=uexactt(1,:);
for n=1:Nn
    for i=2:Ni
        ulw((n+1),i)=(-(ulw(n,i+1)-ulw(n,i-1))/2/h+tau/2/(h^2)*(ulw(n,i+1)-2*ulw(n,i)+ulw(n,i-1)))*tau+ulw(n,i);
    end
    %errorlw(n)=norm(ulw((n+1),:)-uexactt((n+1),:))/norm(uexactt((n+1),:));
end

%errorww(kk)=max((ulw(end,:)-uexactt(end,:)));

% 
[x,y]=meshgrid(x,t);
figure(1)
mesh(uy)
figure(2)
mesh(ulax)
figure(3)
mesh(ulw)
figure(4)
mesh(uexactt)
%end





