%% Dijkstra �㷨 MATLAB����
% ��MATLAB �˳�ѧ�����׳����廪��ѧ������, ׿���� ����ɺ ������ ����. 
%% 
% Dijkstra �㷨 
% �����Ȩ���� W
[m,n]=size(W);
%����ֵ
%l(v)�������� v �ı�ţ���ʾ�Ӷ��� u0�� v ��һ��·��Ȩֵ��
%z(v)�������� v �ĸ��ڵ��ţ�����ȷ����·��·�ߡ� 
n=size(W,1);
for i=1:n
    l(i)=W(1,i);
    z(i)=0;
end
i=1;
while i<=n
    for j=1:n
        if l(i)>l(j)+W(j,i)
            l(i)=l(j)+W(j,i);
            z(i)=j-1;
            if j<i
                i=j-1;
            end
        end
    end
    i=i+1;
end
z=z+1;
z
l
%�������zΪ���·��
%�������lΪ���·��

%% floyd�㷨 MATLAB����
%����Ȩ����D
n=size(D,1);
d=D;
for i=1:n
    for j=1:n
        r(i,j)=j;
    end
end
r;
for k=1:n
    for i=1:n
        for j=1:n
            if d(i,k)+d(k,j)<d(i,j)
                d(i,j)=d(i,k)+d(k,j);
                r(i,j)=r(i,k);
            end
        end
    end
end
r
d
%�������d��Ԫ��d(i,j)��Ϊ��vi��vj�����·������
%r���󴢴����·������vi��vj�����·����vi�ȵ�r(i,j)�ٵ�vj

