%% Dijkstra 算法 MATLAB程序
% 《MATLAB 运筹学》配套程序，清华大学出版社, 卓金武 段蕴珊 姜晓慧 编著. 
%% 
% Dijkstra 算法 
% 输入带权矩阵 W
[m,n]=size(W);
%赋初值
%l(v)——顶点 v 的标号，表示从顶点 u0到 v 的一条路的权值；
%z(v)——顶点 v 的父节点标号，用以确定短路的路线。 
n=size(W,1);
for i=1:n
    l(i)=W(1,i);
    z(i)=0;
end
i=1;
while i<=n
    for j=1:n
        if l(i)>l(j)+W(j,i)
            l(i)=l(j)+W(j,i);
            z(i)=j-1;
            if j<i
                i=j-1;
            end
        end
    end
    i=i+1;
end
z=z+1;
z
l
%输出向量z为最短路径
%输出向量l为最短路长

%% floyd算法 MATLAB程序
%输入权矩阵D
n=size(D,1);
d=D;
for i=1:n
    for j=1:n
        r(i,j)=j;
    end
end
r;
for k=1:n
    for i=1:n
        for j=1:n
            if d(i,k)+d(k,j)<d(i,j)
                d(i,j)=d(i,k)+d(k,j);
                r(i,j)=r(i,k);
            end
        end
    end
end
r
d
%输出矩阵d中元素d(i,j)即为从vi到vj的最短路径长度
%r矩阵储存最短路径，从vi到vj的最短路径是vi先到r(i,j)再到vj

