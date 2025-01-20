clc, clear ;
A=input('请输入系数矩阵');
x=input('请以列向量形式输入全为正的初始可行解');
c=input('请输入价值行向量');
beta=input('请输入步长常量');
epsilon=input('请输入误差常数');
format long

while true
    X=diag(x);
    p=(A*(X^2)*A')\(A*(X^2)*c');
    r=c'-A'*p;
    
    e=ones(1,size(A,2));
    if e*X*r>-epsilon&&max(r)<=0
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