function createPlots(turbFlow,spillFlow,inFlow,price,s0,C2A,n)

%% Calculations for Plots

totStor = zeros(n+1,1);  % Total storage in the reservoir
totStor(1) = s0;  % Initial Storage
% Use the time history data to compute the reservoir storage at each step
for ii = 2:length(inFlow)+1
    totStor(ii) = totStor(ii-1) + ...
        (inFlow(ii-1)-turbFlow(ii-1)-spillFlow(ii-1))*C2A;
end

% Days data for plotting
days = (0:n-1)/24;

%% Calculate revenue for this solution

% Optimal strategy
totValue = calculateValue(s0,price,inFlow,turbFlow,spillFlow,C2A,n);
totValue = cumsum(totValue);

% Old strategy
totValue2 = calculateValue(s0,price,inFlow,inFlow,spillFlow,C2A,n);
totValue2 = cumsum(totValue2);

%% Make Plot
figure('Position',[100 100 900 600]);

subplot(2,2,1);
plot(days,price,'-','LineWidth',2,'Color',[0 0.7 0])
title('电价'); ylabel('价格 ($/MWh)'); xlabel('时间 (天)')
grid on

subplot(2,2,2);
plot(days,totValue/1E6,'-','LineWidth',2)
hold on
plot(days,totValue2/1E6,'-r','LineWidth',2)
title('发电量总值'); ylabel('价值 (millions of $)') 
xlabel('时间 (天)')
grid on
legend('优化涡轮流','涡轮流 = 输入流',...
    'Location','northwest')


subplot(2,2,3);
plot(days,turbFlow,'-xb'); hold on; plot(days,spillFlow,'-xr')
title('优化溢流'); ylabel('溢流 (CFS)'); xlabel('时间(天)')
grid on
leg = legend('涡轮流','溢流');
set(leg,'Location','NorthWest');

subplot(2,2,4);
plot([days n/24],totStor,'-b','LineWidth',2)
title('水库总库容'); ylabel('总库容 (AF)')
xlabel('时间(天)')
grid on


