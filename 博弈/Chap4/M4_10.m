clc clear
A=input('请输入系数矩阵');
x=input('请以列向量形式输入x的初始值');
s=input('请以列向量形式输入s的初始值');
p=input('请以列向量形式输入p的初始解');
alpha=input('请输入步长减少常量alpha');
epsilon=input('请输入误差常数epsilon');
e=ones(size(A,2),1);
while true
    if dot(s,x)<epsilon
        disp(x)
        break
    end
    mu=0.99*dot(s,x)/size(A,2);
    X=diag(x);
    S=diag(s);
    DD=sqrt(X*inv(S));
    P=DD*A'*inv(A*DD^2*A')*A*DD;
    v=inv(X)*DD*(mu*e-X*S*e);
    d1=DD*(eye(size(A,2))-P)*v;
    d2=-inv(A*DD^2*A')*A*DD*v;
    d3=inv(DD)*P*v;
        
    min1=inf;
    for i =1:1:length(d1)
        if d1(i)>=0
            continue
        else
            min1=min(-x(i)/d1(i),min1);
        end
    end
    min2=inf;
     for i =1:1:length(d3)
        if d3(i)>=0
            continue
        else
            min2=min(-s(i)/d3(i),min2);
        end
     end
    betap=min(1,alpha*min1);
    betad=min(1,alpha*min2);
    x=x+betap*d1;
    p=p+betad*d2;
    s=s+betad*d3;
end

% 《MATLAB 运筹学》配套程序，清华大学出版社, 卓金武 段蕴珊 姜晓慧 编著. 
