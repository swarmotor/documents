%Chap5.6
% Gomory��ƽ�淨
function [intx,intf]=Gomory(A,c,b,base)

%Լ������:A;
%Ŀ�꺯��ϵ������:c
%Լ���Ҷ�����:b
%��ʼ������base
%Ŀ�꺯��ȡ��С��ʱ���Ա���ֵ:x
%Ŀ�꺯������Сֵ:minf

sz=size(A);
nVia=sz(2);
n=sz(1);
xx=1:nVia;
 
if length(base)~=n
    disp('�������ĸ���Ҫ��Լ��������������!');
    mx=NaN;
    mf=NaN;
    return;
end
 
M=0;
sigma=-[transpose(c) zeros(1,(nVia-length(c)))];
xb=b;
while 1
    [maxs,ind]=max(sigma);
    if maxs<=0
        vr=find(c~=0,1,'last');
        for l=1:vr
            ele=find(base==l,1);
            if(isempty(ele))
                mx(l)=0;
            else 
                mx(l)=xb(ele);
            end
        end
        if max(abs(round(mx)-mx))<1.0e-7
            intx=mx;
            intf=mx*c;
            return;
        else 
            sz=size(A);
            sr=sz(1);
            sc=sz(2);
            [max_x,index_x]=max(abs(round(mx)-mx));
            [isB,num]=find(index_x==base);
            fi=xb(num)-floor(xb(num));
            for i=1:(index_x-1)
                Atmp(1,i)=A(num,i)-floor(A(num,i));
            end
            for i=(index_x+1):sc
                Atmp(1,i)=A(num,i)-floor(A(num,i));
            end
            
            %�����Ե����η��ĳ�ʼ���
            Atmp(1,index_x)=0;
            A=[A zeros(sr,1);-Atmp(1,:) 1];
            xb=[xb;-fi];
            base=[base sc+1];
            sigma=[sigma 0];
            
            %��ż�����η���������
            while 1
                if(xb)>=0
                    if max(abs(round(xb)-xb))<1.0e-7
                        %�ö�ż�����η������������
                        vr=find(c~=0 ,1,'last');
                        for l=1:vr
                            ele =find (base==l,1);
                            if(isempty(ele))
                                mx_1(l)=0;
                            else
                                mx_1(l)=xb(ele);
                            end
                        end
                        intx=mx_1;
                        intf=mx_1*c;
                        return;
                    else 
                        sz=size(A);
                        sr=sz(1);
                        sc=sz(2);
                        [max_x,index_x]=max(abs(round(mx_1)-mx_1));
                        [isB,num]=find(index_x==base);
                        fi=xb(num)-flooor(xb (num));
                        for i=1:(index_x-1)
                            Atmp(1,i)=a(num,i)-floor(A(num,i));
                        
                        end
                        for i=(index_x+1):sc
                            Atmp(1,i)=a(num,i)-floor(a(num,i));
                        end
                        
                        %��һ�ζ�ż�����η������ĳ�ʼ���
                          Atmp(1,index_x)=0;
            A=[A zeros(sr,1);-Atmp(1,:) 1];
            xb=[xb;-fi];
            base=[base sc+1];
            sigma=[sigma 0];
            continue;
                    end
               

                %��ż�����η��Ļ�����������
                else
                    minb_1=inf;
                    chagB_1=inf;
                    sA=size(A);
                    [br,idb]=min(xb);
                    for j=1:sA(2)
                        if A(idb,j)<0
                            bm=sigma(j)/A(idb,j);
                            if bm<minb_1
                                minb_1=bm;
                                chagB_1=j;
                            end
                        end
                    end
                    sigma=sigma-A(idb,:)*minb_1;
                    xb(idb)=xb(idb)/A(idb,chagB_1);
                    A(idb,:)=A(idb,:)/A(idb,chagB_1);
                    for i=1:sA(1)
                        if i ~=idb
                            xb(i)=xb(i)-A(i,chagB_1)*xb(idb);
                            A(i,:)=A(i,:)-A(i,chagB_1)*A(idb,:);
                        end
                    end
                    base=chagB_1;
            end
        end
    end
    else
        minb=inf;
        chagB=inf;
        for j=1:n
            if A(j,ind)>0
                bz=xb(j)/A(j,ind);
                if bz <minb
                    minb=bz;
                    chagB=j;
                end
            end
        end
        sigma=sigma-A(chagB,:)*maxs/A(chagB,ind);
        xb(chagB)=xb(chagB)/A(chagB,ind);
        A(chagB,:)=A(chagB,:)/A(chagB,ind);
        for i=1:n
            if i~=chagB
                xb(i)=xb(i)-A(i,ind)*xb(chagB);
                A(i,:)=A(i,:)-A(i,ind)*A(chagB,:);
            end
        end
        base(chagB)=ind;
end

M=M+1;
if (M==1000000)
    disp('�Ҳ������Ž�!');
    mx=NaN;
    minf=NaN;
    return;
end
end

%�ο�https://wenku.baidu.com/view/ca86a272284ac850ac024211.html