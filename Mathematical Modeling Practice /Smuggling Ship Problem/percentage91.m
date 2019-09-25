x=10.1:0.1:60;
y=0.1:0.1:30;
[x,y]=meshgrid(x,y);
theta=atan(y./x);
fai=atan((y+5.4)./x);
g=exp(-0.5*((theta-20*pi/180).^2+(fai-29*pi/180).^2)*((180/pi)^2))/(2*pi);
%g=g/sum(sum(g));
gi=sum(sum(g))
%mesh(x,y,g)
gmax3000=0;
for k=1:3000
    [maxlie,lieweizhi]=max(g);
    %maxg=[maxlie;lieweizhi];
    [maxv,xm]=max(maxlie);
    ym=lieweizhi(xm);
    %xm=xm*0.1+10;
    %ym=ym*0.1;
    gmax3000=gmax3000+maxv;
    g(ym,xm)=0;
end
gmax3000/gi
    
    