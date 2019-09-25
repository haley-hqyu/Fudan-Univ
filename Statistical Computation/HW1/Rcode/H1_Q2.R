#author:于慧倩 14300180118
#E1_Q2
#-------------------------读存数据，设置迭代初值----------------------
#读取数据并储存在X中
my.data = read.csv('Data1.csv',header = T);
X = (cbind(my.data$V1,my.data$V2));#300*2

#针对二元正态分布函数
N = 2;
n=length(X)/N;

#为选取合适的初值，将数据点平均分为3份，计算各自的协方差矩阵与均值，作为迭代的初值theta
#theta[[k]] (k = 1:3) 的元素名分别为u,sigmaf,tau

#将数据均分为3份,xs为节点
xs = floor(seq(1,n,length.out = 4));

#输入正整数j，(j in 1:3)，返回第j个正态分布的参数theta_j,u,sigmaf,tau

theta_generate = function(j)
{
  theta = list(NULL);
  length(theta) = 3;
  names(theta) = c("u","sigmaf","tau");
  X1 = X[xs[j]:xs[j+1],];
  u = matrix(colMeans(X1));#2*1
  sigmaf = var(X1[,1:2]);#2*2
  theta$u = u;
  theta$sigmaf = sigmaf;
  theta$tau = 1/3;
  return(theta);
}

#生成迭代初值theta0
theta0 = lapply(c(1:3),theta_generate);

#-------------------------------二元正态分布pdf-------------------------
#输入(X,u,sigmaf)，其中X为坐标，u为均值，sigmaf为协方差矩阵
#返回值为xi点对应的概率密度

nvdnorm = function(X,u,sigmaf)
{
  f = 1/(2*pi)/(det(sigmaf)^(1/2))*exp(-1/2*t(X-u)%*%solve(sigmaf)%*%(X-u));
  return(f);
}

#输入前一步的参数theta，返回表示f(X_i,z_ij | theta_j)的i*j阶矩阵
#f(X_i,z_ij | theta_j) = tau_j * nvdorm(X_i,u_j,sigmaf_j)
fx = function(theta)
{
  fx = apply(X,1,function(x) sapply(theta,function(thetaj) thetaj$tau*nvdnorm(x,thetaj$u,thetaj$sigmaf)));
  #300*3
  return(t(fx));
}

#输入表示f(X_i,zij | theta_j)的i*j阶矩阵，返回表示z_ij的i*j阶矩阵
#z_ij = f(X_i,zij | theta_j)/sum(i = 1:n)(f(X_i,zij | theta_j))

z = function(fx)
{
  fx_sum_j = rowSums(fx);
  fx_sum_j_rep = matrix(rep(fx_sum_j,3),nrow = n);
  result = fx/fx_sum_j_rep;
  #300*3
  return(result);
}、

#对某一个固定的j，输入z_ij的期望(i = 1:n)，返回第j个正态分布的下一轮参数
#tau_jnew = (sum(i in 1:n)(z_ij))/n
#u_jnew = (sum(i in 1:n)(z_ij * X_i))/(sum(i in 1:n)(z_ij))
#sigmaf_jnew = (sum(i in 1:n)(z_jk * (X_i - u_j)*(X_i - u_j)^T))/(sum(i in 1:n)(z_ij))

theta_j = function(z_j)
{
  sumz_j = sum(z_j);
  tauj = sumz_j/n; 
  #计算tau_k'
  uj = t(z_j %*% X)/sumz_j; 
  #计算a_k'
  #计算B_k'
  temp = apply(X,1,function(x) (x - uj)%*%t(x - uj)); 
  temp2 = z_j%*%t(temp); 
  sigmaf0 = matrix(temp2,nrow = N)/sumz_j;
  theta = list(u = uj, sigmaf = sigmaf0, tau = tauj);
  return(theta);
}

#迭代下一次的参数
theta = function(zij)
{
  result = apply(zij,2,theta_j)
  return(result);
}

#--------------------------------循环迭代-------------------------
nonstop = TRUE;
t = 0;
Tol = 1e-16; #设置精度

while(nonstop&&t<1000)
{
  #E step
  fx_ij = fx(theta0); 
  z_ij = z(fx_ij); 
  #M step
  theta1 = theta(z_ij); 
  #当两次计算结果差距小于精度时退出循环
  nonstop = (norm(theta1[[1]]$u - theta0[[1]]$u) > Tol); 
  t = t+1; #迭代次数
  theta0 = theta1;
}



#----------------------------------作图-------------------------------------
#二维正态分布的概率密度函数
nvdnorm_xy = function(x,y,u,sigmaf)
{
   X =rbind(x,y);
   f = 1/(2*pi)/(det(sigmaf)^(1/2))*exp(-1/2*t(X-u)%*%solve(sigmaf)%*%(X-u));
   return(f);
}

#计算(x,y)点在该三个二元正态分布混合分布中出现的概率
fx = function(x,y)
{
  result = theta0[[1]]$tau * nvdnorm_xy(x,y,theta0[[1]]$u,theta0[[1]]$sigmaf)+
           theta0[[2]]$tau * nvdnorm_xy(x,y,theta0[[2]]$u,theta0[[2]]$sigmaf)+
           theta0[[3]]$tau * nvdnorm_xy(x,y,theta0[[3]]$u,theta0[[3]]$sigmaf);
  return(result)
}

  plot(X[,1],X[,2],main="The distribution of Data1 and Their Probability Density",xlab = "V1",ylab = "V2");
 

#做等高线图
  xmin = floor(min(my.data$V1));
  xmax = ceiling(max(my.data$V1));
  ymin = floor(min(my.data$V2));
  ymax = ceiling(max(my.data$V2)); 

  x = seq(xmin,xmax,length.out = 200);
  y = seq(ymin,ymax,length.out = 200);
  result = sapply(y,function(y) sapply(x, function(x) fx(x,y)));
  z = matrix(c(result),nrow = 200,ncol = 200);
  contour(x,y,z,add = TRUE);

#--------------------------------输出结果-----------------------------------
catagory = apply(z_ij,1,which.max);
cat("The final results are as follows:\n",
    "tau_1 = ",theta0[[1]]$tau,"; u_1 = ",theta0[[1]]$u,"; sigma_1 = ",theta0[[1]]$sigmaf,".\n",
    "tau_2 = ",theta0[[2]]$tau,"; u_2 = ",theta0[[2]]$u,"; sigma_2 = ",theta0[[2]]$sigmaf,".\n",
    "tau_3 = ",theta0[[3]]$tau,"; u_3 = ",theta0[[3]]$u,"; sigma_3 = ",theta0[[3]]$sigmaf,".\n",
    "The catagory of each point of Data1 is as follows: \n",catagory,".\n")


