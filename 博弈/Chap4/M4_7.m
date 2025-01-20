clc clear
A=input('请输入系数矩阵');
x=input('请以列向量形式输入x的初始值');
s=input('请以列向量形式输入s的初始值');
c=input('请输入价值行向量c');
p=input('请以列向量形式输入p的初始解');
mu=input('请输入参数mu');
alpha=input('请输入步长减少常量alpha');
epsilon=input('请输入误差常数epsilon');
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
