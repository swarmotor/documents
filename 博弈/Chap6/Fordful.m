%% Ford-Fulkerson 算法 MATLAB程序
% Ford-Fulkerson 算法
%输入C
function [f w]=Fordful(C,f0)
%输入：C为容量，f0为当前流量，若不给出则认为f0=0
%输出：f为最大流，w为最大流量
n=length(C);
if nargin==1;
    f=zeros(n,n);
else
    f=f0;
end
Z1=zeros(1,n);
d=zeros(1,n);
while (1)
    Z1(1)=n+1;
    d(1)=inf;
    while (1)
        pp=1;
        for i=1:n
            if (Z1(i))
                for j=1:n
                    if Z1(j)==0&f(i,j)<C(i,j)
                        Z1(j)=i;
                        d(j)=C(i,j)-f(i,j);
                        pp=0;
                        if d(j)>d(i)
                            d(j)=d(i);
                        end
                    elseif Z1(j)==0&f(i,j)>0
                        Z1(j)=-i;
                        d(j)=f(i,j);
                        pp=0;
                        if d(j)>d(i)
                            d(j)=d(i);
                        end
                    end
                end
            end
        end
        if Z1(n)|pp
            break
        end
    end
    if(pp)
        break
    end
    dvt=d(n);
    t=n;
    while (1)
        if Z1(t)>0
            f(Z1(t),t)=f(Z1(t),t)+dvt;
        elseif Z1(t)<0
            f(Z1(t),t)=f(Z1(t),t)-dvt;
        end
        if Z1(t)==1
            for i=1:n
                Z1(i)=0;
                d(i)=0;
            end
            break
        end
        t=Z1(t);
    end
end
w=0;
for j=1:n
    w=w+f(1,j);
end
f
w

% 《MATLAB 运筹学》配套程序，清华大学出版社, 卓金武 段蕴珊 姜晓慧 编著. 
