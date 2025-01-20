clc, clear ;
A0=input('请输入原来约束条件的系数矩阵');
b=input('请输入该矩阵对应的资源列向量');
c0=input('请按照顺序输入原来价值系数行向量');
p=input('请输入新变量x对应的系数列向量');
addc=input('请输入新变量x对应的价值系数');
format rat
anscell=simplex_method(A0,b,c0);
A=anscell{1};
b=anscell{2};
base=anscell{6};
B=[];
for i=1:1:length(base)
    B=[B A0(:,base(i))];
end
cb=[];
for t=1:1:length(base)
    cb=[cb,c0(base(t))];
end
sigma=addc-dot(cb/B,p);
%计算原问题最终单纯形法表中的sigma
if sigma<=0
    disp('最优解不变，新增的x取为0')
else
    c=[c0,addc];
    A=[A B\p];
    anscell=simplex_method(A,b,c);
    disp('最优解变为')
    disp(anscell{3})
    disp(anscell{4})
end

% 《MATLAB 运筹学》配套程序，清华大学出版社, 卓金武 段蕴珊 姜晓慧 编著. 
