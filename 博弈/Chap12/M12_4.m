% 《MATLAB 运筹学》配套程序，清华大学出版社, 卓金武 段蕴珊 姜晓慧 编著. 
%% 设定购买规则
% 将千支设定为购买的单位，并用原购买数量除以一千后四舍五入的结果作为使用线性规划求解新问题的解
lotSize = 1000;
n = round(n/lotSize);

%%利用整数规划时，先将成本价格和现金流乘以一千
prices = prices*lotSize;
cashFlows = cashFlows*lotSize;
%intlinprog输入的第二项为整数的范围，这里是全部的五个数
intcon = 1:5;
x = intlinprog(prices,intcon,-cashFlows,-obligations,[],[],lb,[]);
x = round(x);
 
%% n是线性规划取整的结果，x是整数规划的结果，我们对这两个结果进行比较。
 
figure;
bar([n x]);%作出直方图
grid on;
set(gca,'XTick',1:5,...
    'XTickLabel',{'Bond 1','Bond 2','Bond 3','Bond 4','Bond 5'});
ylabel('Number of Lots Purchased');
lpLabel = sprintf('Round LP Soln, Cost: $%.2fM',prices'*n/1E6);
milpLabel = sprintf('MILP Soln, Cost: $%.2fM',prices'*x/1E6);
legend(lpLabel,milpLabel);
