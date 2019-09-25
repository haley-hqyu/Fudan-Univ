#author:于慧倩 14300180118
#E1_Q2
#--------------------------------读取数据，设置初值--------------------------------
my.data = read.csv("Data2.csv",header=TRUE);

#计算频数
#Sum_n = sum ((rv in 0:xmax ) rv * its frequency )
xmax = max(my.data$x);
n = as.numeric(table(my.data$x))
Sum_n = sum((0:xmax)*n);

#给定参数初值，将所有数据均值作为lambda初值，频数(rv = 0)作为p初值
p = n[1]/sum(n);
lambda = mean(my.data$x);

#--------------------------------迭代计算--------------------------------
#给定与参数比较的p2,l任意的初始值,当两次计算结果差距小于精度时退出循环
t = 1;
p2 = p+2*1e-16;
l = lambda+2*1e-16;
nonstop = TRUE;

while (t<1000&&nonstop>1e-16){
  pA = p/(p+(1-p)*exp(-lambda));
  n0A = pA*n[1];
  p2 = p;
  l = lambda;
  p = n0A/100;
  lambda = Sum_n/(100-n0A);
  nonstop = min(abs(p - p2),abs(l-lambda));
  t = t+1;#记录迭代次数
}

#--------------------------------作图与屏幕输出------------------------------
hist(my.data$x,breaks = seq(-0.5, 10.5, 1),xlab = "random variable",ylab = "frequency",main = "rv and its frequency");
cat("The final result is as follows: \n",
	"p =" ,p ,
	"\n lambda =" ,lambda );