clc clear
c=[3,-5,0,0,0];
A=[3,2,-1,0,0;1,1,0,1,0,;1,-1,0,0,-1];
b=[5;3;0];
beta=0.3;
gamma=0.3;
q=10;
epsilon=1e-3;
format long
e=ones(size(A,2),1);
L=b-A*e;
A=[A,L,zeros(size(A,1),1)];
A=[A;e'-c,0,1];
x=[e;1;1e5-(e'-c)*e];
s=[e;1e5;1];
p=zeros(size(A,1),1);
p(end)=-1;
while true
    x0=x(1:end-2);
    fadd=dot(x0,c);
    x1=x(1);
    x2=x(2);
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
        xx=x+d;
        xx0=xx(1:end-2);
        faddxx=dot(xx0,c);
        xx1=xx(1);
        xx2=xx(2);
        quiver3(x1, x2, fadd,xx1-x1, xx2-x2, faddxx-fadd,'LineWidth',1.5,'MaxHeadSize',0.5)
        hold on
        quiver3(x1, x2, -4 ,xx1-x1, xx2-x2, 0,'LineWidth',1,'MaxHeadSize',0.5,'LineStyle','--')    
        hold on
        x=xx;
    else
        s=dot(s,x)/q*inv(X)*(u+ones(size(A,2),1));
        p=p+inv(A*X^2*A')*A*X*(X*s-dot(s,x)/q*ones(size(A,2),1));
    end
end
for i=-2:2:4
    syms f(x,y)
    f(x,y) = i;
    fmesh(f,[1 2.2 0.5 1.5],'MeshDensity',10)
    xlabel('x1')
    ylabel('x2')
    zlabel('y')
    alpha(0)
    hold on
end
view(15,10)

% 《MATLAB 运筹学》配套程序，清华大学出版社, 卓金武 段蕴珊 姜晓慧 编著. 