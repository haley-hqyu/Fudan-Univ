y_arrive=[ 1 5 5 5 8 8 11 9 13 21 26 24 31 39 44 46 53 48 43 40 34 43 30 30 23 25 24 16 20 18 11 7 4 2 ];
t=zeros(1);
%�赽�����ָ���ֲ���ÿ���˵���ʳ�õ�ʱ�䣻
for i=10:30;
    k=0;
    while(k<=300)
        y=rand(1,1);
        x=-(300/y_arrive(i))*log(y);
        k=k+x;
        t=[t k+300*(i-10)];
    end
end
%plot(t);
a=1;
z=ones(6,6);
for N=1:6;
    b=1;
 for M=80:10:130;
     %����ÿ���˵ȴ�ʱ��
     p=length(t);
     tn=1/2.*(30+3^(1/2).*randn(1,p)+abs(30+3^(1/2).*randn(1,p)));
     %����ѧ���򷹵�ʱ��������ÿ���˴���Ҫ30�룻
     tm=1/2.*(900+120^(1/2).*randn(1,p)+abs(900+120^(1/2).*randn(1,p)));
     %����ѧ���Է���ʱ������,��ֵΪ15����;
     tt=zeros(1,p);
     waitfood=zeros(1,p); %��¼ѧ���򷹵ĵȴ�ʱ��
     empty=zeros(1); %��¼���ڵĿ���ʱ��
     for i=1:p;
         if i<=N
             tt(i)=t(i)+tn(i);
         else
             waitinline=tt(i-1);
             for j=2:N
                 waitinline=[waitinline tt(i-j)];
                 end
                 lastpeo=min(waitinline);
                 if (t(i)>lastpeo)
                     tt(i)=t(i)+tn(i);
                     empty=empty+t(i)-lastpeo;
                 else
                     tt(i)=lastpeo+tn(i);
                     waitfood(i)=lastpeo-t(i); 
                 end
         end
     end
         %����Է�ʱ��
         tt=sort(tt);
         emptyofseat=zeros(1);
         waitseat=zeros(1,p);
         for i=1:p 
             if i<=M
                 ttt(i)=tt(i)+tm(i);
             else
                 eating=ttt(i-1);
                 for j=2:M
                     eating=[eating ttt(i-j)];
                 end
                 lastpeo=min(eating);
                 if (tt(i)>lastpeo)
                     ttt(i)=tt(i)+tm(i);
                     emptyofseat=emptyofseat+tt(i)-lastpeo;
                 else
                     ttt(i)=lastpeo+tm(i);
                     waitseat(i)=lastpeo-tt(i);
                 end
             end
         end
         tq=0;
         te=0;
         for i=1:p
             tq=waitfood(i)+tq;
         end
         for i=1:p
             te=waitseat(i)+te;
         end
         sumot=(te+tq)/p;
         z(a,b)=sumot;
         b=b+1;
     end
     a=a+1;
end
aa=1:6;
bb=100:10:150;
[x,y]=meshgrid(aa,bb);
surf(z)tup
axis square
xlabel('��λ��/��');
ylabel('����������');
zlabel('�ȴ�ʱ�䣯��');

