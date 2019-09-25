a1=[tan(31/180*pi),-1];
a2=[tan(22/180*pi),-1];
a3=[tan(18/180*pi),-1];
a4=[tan(27/180*pi),-1];
A=[a3;a1]\[0;5.43];
B=[a3;a4]\[0;5.43];
C=[a2;a4]\[0;5.43];
D=[a1;a2]\[5.43;0];
plot([A(1),B(1)],[A(2),B(2)]);
hold on 
plot([B(1),C(1)],[B(2),C(2)]);
plot([C(1),D(1)],[C(2),D(2)]);
plot([D(1),A(1)],[D(2),A(2)]);hold off
alpha=input('please input the angle:');
zig=((C-A)./norm(C-A))';
zag=[cos(-alpha/180*pi),sin(-alpha/180*pi);-sin(-alpha/180*pi),cos(-alpha/180*pi)]*zig';
zig=[zag(2),-zag(1)];
zig1=zig*775/5279.986877;
plane=A'+zig1;
k=norm(plane);
n=0;
while k<221
    p1=[zig;a2]\[dot(zig,plane);0];
    p2=[zig;a1]\[dot(zig,plane);5.43];
    if norm(p1'-plane)<norm(p2'-plane)
        p1temp=p1'+zig1;
        hold on
        plot([p1(1),plane(1)],[p1(2),plane(2)]);
        plot([p1(1),p1temp(1)],[p1(2),p1temp(2)]);
        hold off
        k=k+norm(p1'-plane)+norm(zig1);
        plane=p1temp;
    else
        p2temp=p2'+zig1;
        hold on
        plot([p2(1),plane(1)],[p2(2),plane(2)]);
        plot([p2(1),p2temp(1)],[p2(2),p2temp(2)]);
        hold off
        k=k+norm(p2'-plane)+norm(zig1);
        plane=p2temp;
    end
    n=n+1;
    p1=[zig;a3]\[dot(zig,plane);0];
    p2=[zig;a4]\[dot(zig,plane);5.43];
    if norm(p1'-plane)<norm(p2'-plane)
        p1temp=p1'+zig1;
        hold on
        plot([p1(1),plane(1)],[p1(2),plane(2)]);
        plot([p1(1),p1temp(1)],[p1(2),p1temp(2)])
        hold off
        k=k+norm(p1'-plane)+norm(zig1);
        plane=p1temp;
    else
        p2temp=p2'+zig1;
        hold on
        plot([p2(1),plane(1)],[p2(2),plane(2)]);
        plot([p2(1),p2temp(1)],[p2(2),p2temp(2)]);
        hold off
        k=k+norm(p2'-plane)+norm(zig1);
        plane=p2temp;
    end
    n=n+1;
end
%f=@(theta,fai) exp(-0.5*((theta-20).^2+(fai-29).^2))/(2*pi);
thetamin=18;
thetamax=22;
faimin=27;
faimax=31;
if dot(zig,plane)>0;
    f=@(theta,fai) exp(-0.5*((theta-20).^2+(fai-29).^2))/(2*pi).*((zag(2).*(5.4./(tan(fai./180.*pi)-tan(theta./180.*pi)))-zag(1).*(5.4.*tan(theta./180.*pi)./(tan(fai./180.*pi)-tan(theta./180.*pi))))<dot(zig,plane));
    q=dblquad(f,thetamin,thetamax,faimin,faimax);
else
    f=@(theta,fai) exp(-0.5*((theta-20).^2+(fai-29).^2))/(2*pi).*((zag(2).*(5.4./(tan(fai./180.*pi)-tan(theta./180.*pi)))-zag(1).*(5.4.*tan(theta./180.*pi)./(tan(fai./180.*pi)-tan(theta./180.*pi))))>dot(zig,plane));
    q=dblquad(f,thetamin,thetamax,faimin,faimax); 
    
end   
axis equal




        
        
        
        
    
    
