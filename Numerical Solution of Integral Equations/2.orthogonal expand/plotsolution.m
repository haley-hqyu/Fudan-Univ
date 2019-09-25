function yy = plotsolution(c,y,x0,lambda)
%PLOTSOLUTION 
%   此处显示详细说明
n=round((length(c)-1)/2);
yy=y(x0)+c(1)/sqrt(2*pi)*ones(size(x0));
for i=1:n
    yy=yy+c(2*i)*cos(i*x0)/sqrt(pi)+c(2*i+1)*sin(i*x0)/sqrt(pi);
end
yy=yy/lambda;
end

