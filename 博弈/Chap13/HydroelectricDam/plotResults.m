function plotResults(price,x,N)

%% Create a new figure
figure;

%% Top plot of price data
subplot(2,1,1);
plot(price)
% Add labels
xlabel('时间 (hrs)');
ylabel('价格 ($/MWh)');
title('电价');

%% Bottom plot is flow rates
subplot(2,1,2);
plot(x(1:N),'-*b');
hold on;
plot(x(N+1:end),'-*r');
% Add labels
xlabel('流量 (CFS)');
ylabel('时间(hrs)');
title('溢流和涡轮流量');
% Add legend in upper left (NorthWest) corner
legend('涡轮流量','溢流流量','Location','NorthWest');