clc clear
A=input('请输入系数矩阵');
x=input('请以列向量形式输入x的初始值');
s=input('请以列向量形式输入s的初始值');
p=input('请以列向量形式输入p的初始解');
beta=input('请输入步长值beta');
gamma=input('请输入gamma值');
q=input('请输入大于n的q');
epsilon=input('请输入误差常数epsilon');
while true
    if dot(s,x)<epsilon
        disp(x)
        break
    end
    X=diag(x);
    AA=(A*X)'*inv(A*X^2*A')*A*X;
    u=(eye(size(A,2))-AA)*(q/dot(s,x)*X*s-ones(size(A,2),1));
    d=-beta*X*u/norm(u);
    if norm(u)>=gamma
        x=x+d;
    else
        s=dot(s,x)/q*inv(X)*(u+ones(size(A,2),1));
        p=p+inv(A*X^2*A')*A*X*(X*s-dot(s,x)/q*ones(size(A,2),1));
    end
end

% 《MATLAB 运筹学》配套程序，清华大学出版社, 卓金武 段蕴珊 姜晓慧 编著. 
