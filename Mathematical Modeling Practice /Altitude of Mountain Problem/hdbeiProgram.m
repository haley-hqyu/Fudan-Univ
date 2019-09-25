uh=1/sqrt(3);
up=0.1/sqrt(3);
h0=[0 263 641 909 1208 1502 1812 2143 2397 2766 2951];
p0=[781.3 754.0 716.0 689.9 661.6 634.6 607.0 578.5 557.3 527.5 513.0];
A=[];
B=[];
C=[];
H=[];
for k=1:100000
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
    k=(sum(lh.*lp)-sum(lh)*sum(lp)/11)/(sum(lh.*lh)-sum(lh)*sum(lh)/11);
    A=[A k];
    b=mean(lp)-k*mean(lh);
    B=[B b];
    C=[C round(start)];
    H=[H exp((log(1013.25)-b)/k)-C];
end
bzA=sqrt(var(A));
TA=zeros(1,ceil((max(A)-min(A))/(bzA/2)));
TA1=ceil((A-min(A))/(bzA/2)+0.5);
for l=1:ceil((max(A)-min(A))/(bzA/2))
    TA(l)=length(find(TA1==l));
end
%bar(1:ceil((max(A)-min(A))/(bzA/2)),TA)
bzB=sqrt(var(B));
TB=zeros(1,ceil((max(B)-min(B))/(bzB/2)));
TB1=ceil((B-min(B))/(bzB/2)+0.5);
for l=1:ceil((max(B)-min(B))/(bzB/2))
    TB(l)=length(find(TB1==l));
end
%bar(1:ceil((max(B)-min(B))/(bzB/2)),TB)
bzC=sqrt(var(C));
TC=zeros(1,ceil((max(C)-min(C))/(bzC)/2));
TC1=ceil((C-min(C))/((bzC)/2)+0.5);
for l=1:ceil((max(C)-min(C))/((bzC)/2))
    TC(l)=length(find(TC1==l));
end
%bar(1:ceil((max(C)-min(C))/((bzC)/2)),TC)
bzH=sqrt(var(H));
TH=zeros(1,ceil((max(H)-min(H))/(bzH)/2));
TH1=ceil((H-min(H))/((bzH)/2)+0.5);
for l=1:ceil((max(H)-min(H))/((bzH)/2))
    TH(l)=length(find(TH1==l));
end
%bar(1:ceil((max(H)-min(H))/((bzH)/2)),TH)