clc clear
c=[3,-5,0,0,0];
A=[3,2,-1,0,0;1,1,0,1,0,;1,-1,0,0,-1];
b=[5;3;0];
alpha0=0.9;
epsilon=1e-3;
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
    x0=x(1:end-2);
    c0=c(1:end-2);
    fadd=dot(x0,c0);
    x1=x(1);
    x2=x(2);
    if dot(x,s)<epsilon
        disp(x)
        break
    end
    X=diag(x);
    mu=alpha0*mu;
    d=(eye(size(A,2))-X^2*A'*inv(A*X^2*A')*A)*(X*e-1/mu*X^2*c');
    p=inv(A*X^2*A')*A*(X^2*c'-mu*X*e);
    xx=x+d;
    xx0=xx(1:end-2);
    faddxx=dot(xx0,c0);
    xx1=xx(1);
    xx2=xx(2);
    quiver3(x1, x2, fadd,xx1-x1, xx2-x2, faddxx-fadd,'LineWidth',1.5,'MaxHeadSize',0.5)
    hold on
    quiver3(x1, x2, -4 ,xx1-x1, xx2-x2, 0,'LineWidth',1,'MaxHeadSize',0.5,'LineStyle','--')    
    hold on
    x=xx;
    s=c'-A'*p;
end
for i=-4:2:2
    syms f(x,y)
    f(x,y) = i;
    fmesh(f,[0.6 1.6 0.5 1.5],'MeshDensity',10)
    alpha(1)
    xlabel('x1')
    ylabel('x2')
    zlabel('y')
    hold on
end
view(15,10)

% 《MATLAB 运筹学》配套程序，清华大学出版社, 卓金武 段蕴珊 姜晓慧 编著. 
