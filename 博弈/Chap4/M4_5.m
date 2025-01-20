clc clear
A=input('请输入系数矩阵');
b=input('请输入资源列向量b');
c=input('请输入价值行向量c');
beta=input('请输入步长值beta');
gamma=input('请输入gamma值');
q=input('请输入大于n+2的q');
epsilon=input('请输入误差常数epsilon');
e=ones(size(A,2),1);
L=b-A*e;
A=[A,L,zeros(size(A,1),1)];
A=[A;e'-c,0,1];
x=[e;1;1e5-(e'-c)*e];
s=[e;1e5;1];
p=zeros(size(A,1),1);
p(end)=-1;
while true
    if dot(s,x)<epsilon
        x=x(1:end-2);
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
        dot(s,x)
    end
end

% 《MATLAB 运筹学》配套程序，清华大学出版社, 卓金武 段蕴珊 姜晓慧 编著. 