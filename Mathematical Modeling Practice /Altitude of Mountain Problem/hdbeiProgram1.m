uh=1/sqrt(3);
up=0.1/sqrt(3);
h0=[0 263 641 909 1208 1502 1812 2143 2397 2766 2951];
p0=[781.3 754.0 716.0 689.9 661.6 634.6 607.0 578.5 557.3 527.5 513.0];
A=[];
B=[];
C=[];
H=[];
for k=1:1000
    h=h0+uh*(2*rand(1,11)-1);
    p=p0+up*(2*rand(1,11)-1);
    lp=log(p);
    R=ones(1,10);
    start=0;
    step=10000;
    while step>0.5
        for n=1:10
            lh=log(start+step*n-h);
            R(n)=real(min(min(corrcoef(lh,lp))));
        end
        [m,where]=max(R);
        start=start+(where-1)*step;
        step=step/5;
    end
    a=(sum(lh.*lp)-sum(lh)*sum(lp)/11)/(sum(lh.*lh)-sum(lh)*sum(lh)/11);
    A=[A a];
    lha=mean(lh);
    lpa=mean(lp);
    b=lpa-a*lha;
    B=[B b];
    C=[C round(start)];
    H=[H exp((log(1013.25)-b)/a)-round(start)];
end
subplot(2,2,1);
p1=capaplot(A,[min(A) max(A)]); grid on; axis tight;
subplot(2,2,2);
p2=capaplot(B,[min(B) max(B)]); grid on; axis tight;
subplot(2,2,3);
p3=capaplot(C,[min(C) max(C)]); grid on; axis tight;
subplot(2,2,4);
p4=capaplot(H,[min(H),max(H)]); grid on; axis tight;
