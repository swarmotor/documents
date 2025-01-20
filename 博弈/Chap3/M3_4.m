clc, clear ;
A0=input('请输入原来约束条件的系数矩阵');
b=input('请输入该矩阵对应的资源列向量');
c0=input('请按照顺序输入原来价值系数行向量');
count=input('请输入A的第几列被改变了');
p=input('请输入改变后的列向量');
changec=input('请输入改变后的价值系数');
format rat
anscell=simplex_method(A0,b,c0);
A=anscell{1};
b=anscell{2};
base=anscell{6};
c=c0;
c(count)=changec;
B=[];
for i=1:1:length(base)
    B=[B A0(:,base(i))];
end
cb=[];
for t=1:1:length(base)
    cb=[cb,c0(base(t))];
end
sigma=changec-dot(cb/B,p);
p1=B\p;
if ismember(count,base) %改变B
    A=[A(:,1:count) p1 A(:,count+1:end)];
    bA=[b A];

    out=find(A(:,count));
    bA(out,:)=bA(out,:)/bA(out,count+2);
    
    for i=1:1:size(A,1)
        if i==out
            continue
        end
        d=bA(i,count+2);
        bA(i,:)=bA(i,:)-d*(bA(out,:));
    end
  
    b=bA(:,1);
    A=bA(:,2:end);
A=[A(:,1:count-1) A(:,count+1:end)];
%让新的x对应单纯形法表中的列向量仍为原来形式的标准单位列向量
    if min(b)>=0
        anscell=simplex_method(A,b,c);
        disp(anscell{3})
        disp(anscell{4})
%原问题有可行解，直接用单纯形法
    else
        for i=1:1:length(b)
            if b(i)<0
                bA(i,:)=-bA(i,:);
            end
        end
        b=bA(:,1);
        A=bA(:,2:end);
        A=[A(:,1:count-1) A(:,count+1:end)];
        [RANGE10,RANGE20]=size(A);
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

        if isempty(findj0)
            base0=[];
            add=(1:RANGE10);
            findj10=[];
        else
            findj10=sortrows(findj0');
            base0=findj10(:,2);
        end

        if~isempty(base0)
            add=setdiff((1:RANGE10),findj10(:,1));
        end

        for i=1:1:length(add)
            l=zeros(RANGE10,1);
            l(add(i))=1;
            A=[A l];
        end
        
        c00=zeros(1,length(add)+RANGE20);
        for i=1:1:length(add)
            c00(RANGE20+i)=-1;
        end

        anscell=simplex_method(A,b,c00);
        optans=anscell{4};
        A=anscell{1};
        b=anscell{2};

        if optans~=0
            fprintf('无可行解')
        else
            A=A(:,1:RANGE20);
            anscell=simplex_method(A,b,c);
            disp(anscell{5})
            disp(anscell{3})
            disp(anscell{4})
        end
end
%原问题不是可行解时，用两阶段法
else
    if sigma<=0
        disp('最优解仍为')
        disp(anscell{4})
        disp(dot(anscell{4},c))
    else
        A(:,count)=p1;
        anscell=simplex_method(A,b,c);
        disp(anscell{5})
        disp(anscell{3})
        disp(anscell{4})
    end
end
%改变N

% 《MATLAB 运筹学》配套程序，清华大学出版社, 卓金武 段蕴珊 姜晓慧 编著. 
