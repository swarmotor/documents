clc, clear
c0=[-3,5,0,0,0];
A=[3,2,-1,0,0;1,1,0,1,0,;1,-1,0,0,-1];
b=[5;3;0];
beta=0.3;
epsilon=1e-3;
format long
c=[c0 -1e5];
e=ones(size(A,2),1);
A=[A b-A*e];
x=[e;1];

while true
    X=diag(x);
    p=(A*(X^2)*A')\(A*(X^2)*c');
    r=c'-A'*p;
    e=ones(1,size(A,2));
    x0=x(1:end-1);
    fadd=dot(x0,c0);
    x1=x(1);
    x2=x(2);
    if e*X*r>-epsilon&&max(r)<=0
        break
    elseif min(X^2*r)>=0
        disp('有无界解')
        break
    else
        xx=x+beta*(X^2*r/norm(X*r));
        xx0=xx(1:end-1);
        faddxx=dot(xx0,c0);
        xx1=xx(1);
        xx2=xx(2);
        quiver3(x1, x2, fadd,xx1-x1, xx2-x2, faddxx-fadd,'LineWidth',1.5,'MaxHeadSize',0.5)
        hold on
        quiver3(x1, x2, -2 ,xx1-x1, xx2-x2, 0,'LineWidth',1,'MaxHeadSize',0.5,'LineStyle','--')    
        hold on
        x=xx;
    end
end
for i=0:1:3
    syms f(x,y)
    f(x,y) = i;
    fmesh(f,[1 1.6 0.5 1.5],'MeshDensity',10)
    xlabel('x1')
    ylabel('x2')
    zlabel('y')
    alpha(0)
    hold on
end
view(-25,10)

% 《MATLAB 运筹学》配套程序，清华大学出版社, 卓金武 段蕴珊 姜晓慧 编著. 
