%�淶һЩ��ʼ��ֵ�͸����ܶ�����
sg=[19 18 17 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1 0;6 8 10 12 13 14 15 16 16 17 17 18 18 19 19 19 19 19 19 19];
cg=[8 7 6 5 4 3 2 1 0;4 5 6 7 8 8 8 8 8];
%database
x=10.1:0.1:60;
y=0.1:0.1:30;
[x,y]=meshgrid(x,y);
theta=atan(y./x);
fai=atan((y+5.4)./x);
g=exp(-0.5*((theta-20*pi/180).^2+(fai-29*pi/180).^2)*((180/pi)^2))/(2*pi);
gi=sum(sum(g));
%g=g/gi;
%mesh(x,y,g)
helo=[24.7 6.4];%ֱ������λ��%
helol=helo';%ֱ������λ�ù��ɵĵ���%

for k=1:52000
    %%
    %���������λ��
    [maxlie,lieweizhi]=max(g);
    %maxg=[maxlie;lieweizhi];
    [maxv,xm]=max(maxlie);
    ym=lieweizhi(xm);
    xm=xm*0.1+10;
    ym=ym*0.1;

    %%
    %��ֱ������Χ3x3ϸ��
    helog=floor(10*helo)/10;
    xxi=helog(1)-0.15:0.1/21:helog(1)+0.15;
    yxi=helog(2)-0.15:0.1/21:helog(2)+0.15;
    [xxi,yxi]=meshgrid(xxi,yxi);
    thetaxi=atan(yxi./xxi);
    faixi=atan((yxi+5.4)./xxi);
    gxi=exp(-0.5*((thetaxi-20*pi/180).^2+(faixi-29*pi/180).^2)*((180/pi)^2))/(2*pi);
    gxi=gxi/gi;
 
    %%
    %ֱ���������������ĵط��ƶ�
    if abs(xm-helo(1))>=abs(ym-helo(2))
        helo(1)=helo(1)+sign(xm-helo(1))*0.1/21;
    else
        helo(2)=helo(2)+sign(ym-helo(2))*0.1/21;
    end
    %%
    %ֱ�����Ĺ켣
    if mod(k,100)==0%��¼ֱ����ÿ��100�κ��λ��
        helol=[helol helo'];
    end
    %%
    %ֱ����200Ӣ����ץס����˽��
    heloxig=round((helo-helog+[0.1,0.1])/(0.1/21));
    for z=-8:8
        gxi(heloxig(2)+z,heloxig(1)-cg(2,9-abs(z)):heloxig(1)+cg(2,9-abs(z)))=0;
    end
    %%
    %ֱ����200~500Ӣ����,��˽��������
    if mod(k,3)==0%ֱ����ÿ������,��˽����һ��
        for m=[-19:0 19:-1:1]
            for n=[-sg(2,20-abs(m)):0 sg(2,20-abs(m)):-1:1]
                if m>=n
                    gxi(heloxig(2)+m+sign(m),heloxig(1)+n)=gxi(heloxig(2)+m+sign(m),heloxig(1)+n)+gxi(heloxig(2)+m,heloxig(1)+n);
                    gxi(heloxig(2)+m,heloxig(1)+n)=0;
                else
                    gxi(heloxig(2)+m,heloxig(1)+n+sign(n))=gxi(heloxig(2)+m,heloxig(1)+n+sign(n))+gxi(heloxig(2)+m,heloxig(1)+n);
                    gxi(heloxig(2)+m,heloxig(1)+n)=0;
                end
            end
        end
    end
    %%
    %��ϸ�ֺ�ĸ��ӵĸ������,���������ж�
    for p=-4:4
        px=round(p/3);
        py=p-3*round(p/3);
        g(10*helog(2)+py,10*helog(1)-100+px)=min(g(10*helog(2)+py,10*helog(1)-100+px),sum(sum(gxi((22-21*px):(43-21*px),(22-21*py):(43-21*py))))/484);
    end
end
plot(helol(1,:),helol(2,:))%����ͼ��
sum(sum(g))/gi%���ʣ�µĸ�����ԭ���ı�,��1�ĲΪץס���ĸ���
