%H7-2
%����
f=@(u,t,lambda) lambda*(-u+cos(t));

%����ʽEuler��ʽ���
for i=1:4
    lambda=10^(i-1);
    u0=0;
    T=1; 
    dt=10^(-2);
    u=XEuler(lambda,u0,T,dt);
    plot((0:dt:1),u);
    hold on
end

%����ʽEuler��ʽ���
%���
uexact=@(t,lambda,u0) exp(-lambda.*t).*(u0+lambda.*(exp(lambda.*t).*sin(t)+lambda.*exp(lambda.*t).*cos(t)-lambda)./(lambda^2+1));