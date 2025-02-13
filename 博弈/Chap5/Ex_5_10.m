%%
% Eg 5-10
A=[-1  2  1  0 ;2  1  0  1];
c=[1;-1];
b=[2;4];
[intx,intf]=Gomory(A,c,b,[3 4])

%%
% Eg 5-13
f=[-5,-1];
A=[3,1;1,1;1,8];
b=[9;5;8];
lb=[0 0];
ub=[inf, inf];
M=[1,2];
e=2^-24;
[x,v,s]=intprog(f,A,b,[],[],lb,ub,M,e)

%%
%Eg 5-16
f=[1;2;3;1;1];
intcon=1:5;
A=[-2,-3,-5,-4,-7;-1,-2,-4,-2,-2];
b=[-8;-5];
lb=[0,0,0,0,0];
ub=[1,1,1,1,1];
[x,fval] = intlinprog(f,intcon,A,b,[],[],lb,ub)

 % 《MATLAB 运筹学》配套程序，清华大学出版社, 卓金武 段蕴珊 姜晓慧 编著. 