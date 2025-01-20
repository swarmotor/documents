%% 例1-4，利用 linprog 命令解决投资问题
% 《MATLAB 运筹学》配套程序，清华大学出版社, 卓金武 段蕴珊 姜晓慧 编著. 
%%
clc,clear
% 总时间
T = 5;
% 证券数量
N = 4;
%初始金额
Capital_0 = 1000;
% （含假想）债券总数
nPtotal = N+T;
% 可购入的时间
PurchaseYears = [1;2;3;4;5;1;5;2;2];
% 债券时长
Maturity = [1;1;1;1;1;4;1;4;3];
% 收益时间
MaturityYears = PurchaseYears + Maturity - 1;
%收益率
InterestRates = [0;0;0;0;0;2;4;6;6];
finalReturns = (1+InterestRates/100).^Maturity;
%每年收益比
rt = 1 + InterestRates/100;
%调用MATLAB示例中plotInvestments函数
plotInvestments(N,PurchaseYears,Maturity,InterestRates)
f = zeros(nPtotal,1);
f([5,7,8]) = [-finalReturns(5),-finalReturns(7),-finalReturns(8)];
Aeq = spalloc(N+1,nPtotal,15);
Aeq(1,[1,6]) = 1;
Aeq(2,[1,2,8,9]) = [-1,1,1,1];
Aeq(3,[2,3]) = [-1,1];
Aeq(4,[3,4]) = [-1,1];
Aeq(5,[4:7,9]) = [-finalReturns(4),1,-finalReturns(6),1,-finalReturns(9)];
beq = zeros(T,1);
beq(1) = Capital_0;
lb = zeros(size(f));
ub = [];
options = optimoptions('linprog','Algorithm','interior-point');
[xsol,fval,exitflag] = linprog(f,[],[],Aeq,beq,lb,ub,options);
plotInvestments(N,PurchaseYears,Maturity,InterestRates,xsol)
