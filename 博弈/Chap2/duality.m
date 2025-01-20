function anscell=duality(A,b,c)
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
wid=size(findj0,2);
if wid~=RANGE10
    error('A的格式不正确')
end
findj10=sortrows(findj0');
base0=findj10(:,2);
c_z=[];
cb=[];
for t=1:1:length(base0)
    cb=[cb,c(base0(t))];
end

for j=1:1:RANGE20
    z(j)=dot(cb',A(:,j));
    c_z=[c_z c(j)-z(j)];
end
%以上代码在simplex_method中都已经使用过，在这里用于做检验。
if max(c_z)>0
    error('不满足对偶单纯形法的检验数非正条件')
end
while true
    if min(b)>=0
        printword='最优解为';
        optans=dot(cb,b);
        ansx=zeros(1,RANGE20);
        for j=1:1:RANGE10
            ansx(base0(j))=b(j);
        end
        anscell={A,b,ansx,optans,printword,base0};
        break
    end
    liindout=find(b==min(b));
    indout=liindout(1);
    if min(A(indout,:))>=0
        printword='原问题无可行解';
        anscell={A,b,[],[],printword,base0};
        break
    end
    theta=inf;
    for i=1:1:RANGE20
        if ismember(i,find(A(indout,:)<0))
            theta=min(theta,c_z(i)/A(indout,i));
            if c_z(i)/A(indout,i)==theta
                indin=i;
            end
        end
    end
    %获得theta
    bA=[b A];
    bA(indout,:)=bA(indout,:)./bA(indout,indin+1);
    for i=1:1:RANGE10
        if i==indout
            continue
        end
        d=bA(i,indin+1);
        bA(i,:)=bA(i,:)-d*(bA(indout,:));
    end
    
    b=bA(:,1);
    A=bA(:,2:end);
    %换入基做新基得到新的矩阵
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
    findj10=sortrows(findj0');
    base0=findj10(:,2);
    c_z=[];
    cb=[];
    for t=1:1:length(base0)
        cb=[cb,c(base0(t))];
    end

    for j=1:1:RANGE20
        z(j)=dot(cb',A(:,j));
        c_z=[c_z c(j)-z(j)];
    end
%得到新矩阵的各个量以进入下一次循环。    
end
