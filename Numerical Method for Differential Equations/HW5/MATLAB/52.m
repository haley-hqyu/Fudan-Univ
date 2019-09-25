%5_2
[x,y]=meshgrid(-2:0.1:2);
z=x+y*1i;

R20=1+z+1/2.*z.^2;
R2=abs(R20)-1;

figure(1):

c=contours(x,y,R2,[0 0]);
fill(c(1,2:end),c(2,2:end),[0,1,1])
axis([-3 3 -3 3]);