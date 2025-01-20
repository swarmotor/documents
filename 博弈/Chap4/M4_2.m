clc, clear ;
A=input('请输入价值系数A');
b=input('请输入资源列向量b');
c=input('请输入价值行向量c');
beta=input('请输入步长常量');
epsilon=input('请输入误差常数');
format long
c=[c -1e5];
e=ones(size(A,2),1);
A=[A b-A*e];
x=[e;1];
while true
    X=diag(x);
    p=(A*(X^2)*A')\(A*(X^2)*c');
    r=c'-A'*p;
    
    e=ones(1,size(A,2));
    if e*X*r>-epsilon&&max(r)<=0
x=x(1:end-1);
        disp(x)
        break
    elseif min(X^2*r)>=0
        disp('有无界解')
        break
    else
        x=x+beta*(X^2*r/norm(X*r));
    end
end

% 《MATLAB 运筹学》配套程序，清华大学出版社, 卓金武 段蕴珊 姜晓慧 编著. 
