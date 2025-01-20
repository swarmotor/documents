function anscell=simplex_method(A,b,c)

while true
    [RANGE1,RANGE2]=size(A);
    findj=[];
    %findj用来储存所有线性无关的单位列向量的1出现的位置和列向量出现的位置
    for i=1:1:RANGE2
        if length(find(A(:,i)==1))==1&&length(find(A(:,i)))==1
            if isempty(findj)
                ind=find(A(:,i)==1);
                addfindj=[ind;i];
                findj=[findj addfindj];
            elseif~ismember(find(A(:,i)==1),findj(1,:))
                ind=find(A(:,i)==1);
                addfindj=[ind;i];
                findj=[findj addfindj];
            end
        end
    end
    findj1=sortrows(findj');
    %通过这个排序，可以按顺序确定初始基可行解，（之后储存在base中）从而确定相应的cb
    base=findj1(:,2);

    c_z=[];
    cb=[];
    for t=1:1:length(base)
        cb=[cb,c(base(t))];
    end

    for j=1:1:RANGE2
        z(j)=dot(cb',A(:,j));
        c_z=[c_z c(j)-z(j)];
    end
    %依次计算cj-zj，得到行向量
    %后续出现的两个flag是为了进行判断，当已经得到结果后跳出函数主体的死循环
    for i=1:1:RANGE2
        if c_z(i)>0&&max(A(:,i))<=0
            flag1=1;
            printword='无界解';
            anscell={A,b,[],[],printword,base};
            break%只要某个i满足无界解的条件，循环就不需要继续进行了，可以直接break
        else
            flag1=0;
        end
    end
    if max(c_z)<=0
        flag2=1;
        ansx=zeros(1,RANGE2);
        for j=1:1:RANGE1
            ansx(base(j))=b(j);
        end
        %这样做是因为最终解除了基可行解之外的x均为0
        printword='唯一最优解为';%初始将printword进行这样的设定，如果满足无穷解的判定再改正
        for j=1:1:RANGE2
            if ismember(j,base)
                continue%只判断那些非基可行解，因此遇到基可行解，直接进入下一次循环
            elseif c_z(j)==0&&max(A(:,j))>0
                printword='有无穷解，其中一组是';
                break
            end
        end
        optans=dot(c,ansx);
        anscell={A,b,ansx,optans,printword,base};
    else
        flag2=0;
    end

    if flag1==1||flag2==1
        break
    end
    %当以上两个判断都为否时，说明还需要进一步操作
    
    maxc_z=max(c_z);
    liindc_z=find(c_z==maxc_z);
    indc_z=liindc_z(1);
    %根据勃兰特原则，只取第一个出现的
    
    litheta=[];%获得正theta，用于找最小值
    cotheta=[];%获得全部theta，用于下标获取
    for i=1:1:RANGE1
        if A(i,indc_z)>0
            litheta=[litheta b(i)./A(i,indc_z)];
            cotheta=[cotheta b(i)./A(i,indc_z)];
        else
            cotheta=[cotheta inf];
        end
    end
    mintheta=min(litheta);
    liindtheta=find(cotheta==mintheta);
    indtheta=liindtheta(1);
    %根据勃兰特原则， 只取第一个出现的
   
    bA=[b A];%拼接矩阵以便同时操作
    bA(indtheta,:)=bA(indtheta,:)./bA(indtheta,indc_z+1);
    for i=1:1:RANGE1
        if i==indtheta
            continue
        end
        d=bA(i,indc_z+1);
        bA(i,:)=bA(i,:)-d*(bA(indtheta,:));
    end
    %将主元素单位化并通过矩阵初等变化使主元素所在列成为标准单位列向量
    b=bA(:,1);
    A=bA(:,2:end);
    %取得新的A、b，进入下一次循环
end

% 《MATLAB 运筹学》配套程序，清华大学出版社, 卓金武 段蕴珊 姜晓慧 编著. 