% 《MATLAB 运筹学》配套程序，清华大学出版社, 卓金武 段蕴珊 姜晓慧 编著. 
% 导入价格和现金流的数据

prices = importBondPrices('BondData.xlsx');
cashFlows = importCashFlows('BondData.xlsx','CashFlows','A3:E10');
 
nt = size(cashFlows,1); %总时间
nb = size(cashFlows,2); %总债券数目
 
% obligations: nt x 1向量，表示每年的债务
obligations = [4E5 6E5 7E5 7E5 7E5 1.2E6 1.1E6 1.2E6]';
 
%%进行线性规划求解
%需要注意的是，由于题目的约束是大于等于，所以需要进行变号
%债券的购买数目不能为负数
lb = zeros(nb,1);
n = linprog(prices,-cashFlows,-obligations,[],[],lb,[]);
