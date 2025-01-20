%% 例1-2 用单纯形法求解线性规划问题
% 《MATLAB 运筹学》配套程序，清华大学出版社, 卓金武 段蕴珊 姜晓慧 编著. 
%%  输入规划模型
clc, clear 
% A=input('请输入约束条件的系数矩阵');
A = [0 5 1 0 0 ;6 2 0 1 0; 1 1 0 0 1];
% b=input('请输入该矩阵对应的资源列向量');
b = [15 ;24 ; 5];
% c=input('请按照顺序输入价值系数行向量');
c = [2 1 0 0 0 ];

%% 模型求解
format rat
[RANGE10,RANGE20]=size(A);
[b1,b2]=size(b);
if b1~=RANGE10||b2~=1
    error('b的格式不正确')
end
[c1,c2]=size(c);
if c1~=1||c2~=RANGE20
    error('c的格式不正确')
end
%获取A、b、c并判断格式，这里采用b列向量、c行向量是为了与单纯形法表相对应

findj0=[];
for i=1:1:RANGE20
    if length(find(A(:,i)==1))==1&&length(find(A(:,i)))==1
        if isempty(findj0)
            ind0=find(A(:,i)==1);
            addfindj0=[ind0;i];
            findj0=[findj0 addfindj0];
        elseif~ismember(find(A(:,i)==1),findj0(1,:))
            ind0=find(A(:,i)==1);
            addfindj0=[ind0;i];
            findj0=[findj0 addfindj0];
        end
    end
end
%这一段获取findj0的方法与S函数里相同，读者可以参考之前的解释
if isempty(findj0)
    base0=[];
    add=(1:RANGE10);
    findj10=[];
    %初始系数矩阵没有标准单位列向量时，全部由程序生成
else
    findj10=sortrows(findj0');
    base0=findj10(:,2);
    %初始系数矩阵有标准单位列向量时，进行记录便于之后比较
end
    
if length(base0)==RANGE10
    anscell=simplex_method(A,b,c);
    disp(anscell{5})
    disp(anscell{3})
    disp(anscell{4})
    %有基可行解，直接调用S函数
else
    %两阶段法
    if~isempty(base0)
        add=setdiff((1:RANGE10),findj10(:,1));
    end
    %补全标准单位列向量
    for i=1:1:length(add)
        l=zeros(RANGE10,1);
        l(add(i))=1;
        A=[A l];
    end
    %补全A
    c0=zeros(1,length(add)+RANGE20);%生成新的c0，更换变量名以保留c
    for i=1:1:length(add)
        c0(RANGE20+i)=-1;
    end

    anscell=simplex_method(A,b,c0);
    optans=anscell{4};
    A=anscell{1};
    b=anscell{2};
    %得到新的A、b以进行第二阶段
    if optans~=0
        fprintf('无可行解')
    else
        A=A(:,1:RANGE20);%去除人工变量
        anscell=simplex_method(A,b,c);
        disp(anscell{5})
        disp(anscell{3})
        disp(anscell{4})
    end
end