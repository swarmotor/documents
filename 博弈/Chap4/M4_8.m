clc clear
A=input('请输入系数矩阵');
b=input('请输入资源列向量b');
c=input('请输入价值行向量c');
alpha=input('请输入步长减少常量alpha');
epsilon=input('请输入误差常数epsilon');
e=ones(size(A,2),1);
M=1e5;
m1=max(max(A));
m2=max(b);
m3=max(c);
U=max([m1,m2,m3]);
A=[A,b-A*e,zeros(size(A,1),1)];
A=[A;e',0,1];
mu=4*(norm(c)^2+M^2)^(1/2);
x=[e;1;1];
p=[zeros(size(A,1)-1,1);-mu];
s=[c'+mu*e;M+mu;mu];
c=[c,M,0];
e=ones(size(A,2),1);
while true
    if dot(x,s)<epsilon
        disp(x)
        break
    end
    X=diag(x);
    mu=alpha*mu;
    d=(eye(size(A,2))-X^2*A'*inv(A*X^2*A')*A)*(X*e-1/mu*X^2*c');
    p=inv(A*X^2*A')*A*(X^2*c'-mu*X*e);
    x=x+d;
    s=c'-A'*p;
end

% 《MATLAB 运筹学》配套程序，清华大学出版社, 卓金武 段蕴珊 姜晓慧 编著. 