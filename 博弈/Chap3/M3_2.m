clc, clear ;
A0=input('请输入约束条件的系数矩阵');
b=input('请输入该矩阵对应的资源列向量');
c0=input('请按照顺序输入原来价值系数行向量');
c1=input('请按照顺序输入改变后价值系数行向量');
format rat
anscell=simplex_method(A0,b,c0);
A=anscell{1};
b=anscell{2};
base=anscell{6};

c_z=[];
cb=[];
for t=1:1:length(base)
    cb=[cb,c1(base(t))];
end

for j=1:1:length(c1)
    z(j)=dot(cb',A(:,j));
    c_z=[c_z c1(j)-z(j)];
end
%对新的检验数加以判断
if max(c_z)<=0
    disp('最优解仍为')
    disp(anscell{3})
    disp(dot(anscell{3},c1))
else
    anscell=simplex_method(A,b,c1);
    disp('最优解变为')
    disp(anscell{3})
    disp(anscell{4})
end

% 《MATLAB 运筹学》配套程序，清华大学出版社, 卓金武 段蕴珊 姜晓慧 编著. 
