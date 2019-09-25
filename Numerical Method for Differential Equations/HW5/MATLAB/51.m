%5.1
syms x y;
z=x+y*1i;
R10=(1+z/2)/(1-z/2);
R1=abs(R10)-1;
figure(1);
ezplot(R1,[-1,-1,1,1]);hold on
fill([0,0,-1,-1],[-1,1,1,-1],[0,1,1]);hold off
title('abs(1+Z/2)/(1-Z-2)<1');
