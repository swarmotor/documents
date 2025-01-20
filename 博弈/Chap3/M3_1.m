clc, clear ;
A0=input('请输入约束条件的系数矩阵');
b0=input('请输入该矩阵原来对应的资源列向量');
c=input('请按照顺序输入价值系数行向量');
b1=input('请输入该矩阵改变后对应的资源列向量');
format rat
anscell=simplex_method(A0,b0,c);
A=anscell{1};
b=anscell{2};
base=anscell{6};
B=[];
for i=1:1:length(base)
    B=[B A0(:,base(i))];
end

b2=B\b1;
if min(b2)>=0
    ansx=zeros(1,length(c));
    for i=1:1:length(b2)
        ansx(base(i))=b2(i);
    end
    disp('最优解变为')
    disp(ansx)
    disp(dot(ansx,c))
else
    anscell=duality(A,b2,c);
    disp('最优解变为')
    disp(anscell{3})
    disp(anscell{4})
end
%b列仍为非负时采用原来的最优解，出现负值时使用对偶单纯形法得到新的最优解。

% 《MATLAB 运筹学》配套程序，清华大学出版社, 卓金武 段蕴珊 姜晓慧 编著. 
