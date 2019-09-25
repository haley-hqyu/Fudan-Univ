x=10:0.1:60;
y=0:0.1:30;
[x,y]=meshgrid(x,y);
theta=atan(y./x);
fai=atan((y+5.4)./x);
g=exp(-0.5*((theta-20*pi/180).^2+(fai-29*pi/180).^2)*((180/pi)^2))/(2*pi);
g=g/sum(sum(g));
mesh(x,y,g)
