
function[xm,fv]=PSO(fitness,N,c1,c2,w,M,D)
 %参数的意义如4.2.1表格所示
for i=1:1:N
    for j=1:1:D
        x(i,j)=randn;
        v(i,j)=randn;
    end
end
%根据正态分布随机得到粒子的初始位置和速度
for i=1:1:N
    p(i)=fitness(x(i,:));
    y(i,:)=x(i,:);
end
pg=x(N,:);
for i=1:1:N-1
    if fitness(x(i,:))<fitness(pg)
        pg=x(i,:);
    end
end
 %初始化个体最优和全局最优
for t=1:1:M
    for i=1:1:N
        v(i,:)=w*v(i,:)+c1*rand*(y(i,:)-x(i,:))+c2*rand*(pg-x(1,:));
        %更新速度
        x(i,:)=x(i,:)+v(i,:);
		%更新位置
        if fitness(x(i,:))<p(i)
            p(i)=fitness(x(i,:));
            y(i,:)=x(i,:);
			%更新个体最优
        end
        if p(i)<fitness(pg)
            pg=y(i,:);
			%更新全局最优
        end
    end
    pbest(t)=fitness(pg);
end
xm=pg;
fv=fitness(pg);
