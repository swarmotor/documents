clc, clear ;
A=input('请输入原来约束条件的系数矩阵');
b=input('请输入原来该矩阵对应的资源列向量');
c=input('请按照顺序输入价值系数行向量');
a=input('请输入新增约束条件行向量');
addb=input('请输入新增资源限制的值');
format rat
anscell=simplex_method(A,b,c);
b=[anscell{2};addb];
if length(a)==size(A,2)
    A=[anscell{1};a];
    flag=0;
else
    c=[c,0];
    A=[anscell{1},zeros(size(A,1),1)];
    A=[A;a];
    if a(end)==1
        flag=1;%此即小于等于的情况
    else
        flag=0;
    end
end
base=anscell{6};
bA=[b A];
for i =1:1:length(base)
    bA(size(A,1),:)=bA(size(A,1),:)-A(size(A,1),base(i))*bA(i,:);
end
b=bA(:,1);
A=bA(:,2:end);

if flag==1
    anscell=duality(A,b,c);
    disp(anscell{5})
    disp(anscell{3})
    disp(anscell{4})
else%可参见两阶段法，这里更简单一些，由于一定是添加一列且其末数为1
    add=zeros(size(A,1),1);
    add(end)=1;
    A1=[A add];
    c0=zeros(1,length(c)+1);
    c0(end)=-1;
    anscell=duality(A1,b,c0);
    if anscell{4}~=0
        disp('无可行解')
    else
        A2=anscell{1};
        A=A2(:,1:end-1);%去除人工变量
        b=anscell{2};
        anscell=simplex_method(A,b,c);
        disp(anscell{5})
        disp(anscell{3})
        disp(anscell{4})
    end
end

% 《MATLAB 运筹学》配套程序，清华大学出版社, 卓金武 段蕴珊 姜晓慧 编著. 
