function plotInvestments(N,PurchaseYears,Maturity,InterestRates,varargin)
%plotInvestments creates a figure to visualize the setup and
% the solution of the long-term investment example.
% This is a helper function for the Long-Term Investment Example.
%
% To visualize the problem setup:
% plotInvestments(N,PurchaseYears,Maturity,InterestRates)
%
% To visualize the solution:
% plotInvestments(N,PurchaseYears,Maturity,InterestRates,xsol)
%
%   Inputs:
%            N - scalar containing the number of available bonds
% 
% PurchaseYears - nPtotal-by-1 vector containing the purchase year for each
% bond
%
%      Maturity - nPtotal-by-1 vector containing the maturity period for each
%      bond.
%
% InterestRates - nPtotal-by-1 vector containing the expected yearly return for
%       each bond.
%
%   Optional Inputs:
%        xsol - nPtotal-by-1 vector containing the solution to the investment
%        problem.
%
%  smallScale - boolean (true by default). If set to false, the plot only
%  contains lines and no text.

% Determine whether the call is to visualize:
% * the problem setup (plotSol = 0); or
% * the solution (plotSol = 1)
% based on the number of inputs.
plotSol = 0;
smallScale = true;
if nargin > 4
    plotSol = 1;
    xsol = varargin{1};
    if nargin > 5
        smallScale = varargin{2};
    end
end

% Total number of purchase options
nPtotal = length(PurchaseYears);
% Number of years
T = nPtotal-N;

% Create a figure
if smallScale
    figure('Position',[20 100 700 100+25*(N+2)],...
        'Color','w','Units','Pixels')
else
    figure('Position',[20 100 700 700],...
        'Color','w','Units','Pixels')
end
    
% Create an axis
ax = gca;
% Set the axes to fill the entire figure
set(ax,'Position',[0 0 1 1]);
% remove the axis ticks
axis off

hold on

% Define x- and y-spacing for the year and bonds
x = linspace(0.08,0.98,T+1);
xwidth = x(2)-x(1);
xl = 0.02;
if smallScale
    yt = 0.98;
    y = linspace(0.84,0.02,N+2);
    ywidth = y(1)-y(2);
else
    yt = 0.94;
    y = linspace(0.92,0.02,N+2);
    ywidth = y(1)-y(2);
end

% Plot the vertical year lines
xyear = NaN(3*T+2,1);
xyear(1:3:end) = x;
xyear(2:3:end) = x;
yyear = NaN(3*T+2,1);
yyear(1:3:end) = yt;
yyear(2:3:end) = y(end);
plot(xyear,yyear,'k--')
if smallScale
    plot([xl xl],[y(1) y(end)],'k')
end

% if small scale
if smallScale
    % Plot the horizontal bond lines
    xsec = NaN(3*(N+2),1);
    xsec(1:3:end) = xl;
    xsec(2:3:end) = x(end);
    ysec = NaN(3*(N+2),1);
    ysec(1:3:end) = y;
    ysec(2:3:end) = y;
    plot(xsec,ysec,'k')
    plot([x(1) x(end)], [yt yt],'k')
    
    % Add textbox to label each year
    for j=1:T
        annotation('textbox','Position',[x(j) y(1) xwidth yt-y(1)],...
            'String', [ 'Year ' num2str(j)],...
            'VerticalAlignment','Middle', 'HorizontalAlignment','Center',...
            'EdgeColor','none');
    end

    % Add textbox to label each bond
    for i=0:N
       annotation('textbox','Position',[xl y(i+2) x(1)-xl ywidth],...
           'String',['B_' num2str(i) char(10) num2str(InterestRates(i+T)) '%' ],...
            'VerticalAlignment','Middle', 'HorizontalAlignment','Center',...
            'EdgeColor','none');
    end

    % Plot the bonds

    % Start with the first bond on the first line
    for j=1:T
        % Draw a rectangle for each purchase option that extends for the length
        % of the maturity period
        ar = annotation('rectangle','Position',[x(j) y(2) x(j+1)-x(j) ywidth],...
            'FaceColor', [0.8 0.8 0.8]);
        % If visualizing the solution
        if plotSol 
            % Add a textbox containing the amount invested
            annotation('textbox','Position',[x(j) y(2) x(j+1)-x(j) ywidth],...
                'String', ['x' num2str(j) ' = ' num2str(xsol(j),'%.2f')],...
                'VerticalAlignment','middle', 'HorizontalAlignment','Center',...
                'EdgeColor','none');
            % If the amount invested is not too small color the rectangle in
            % red
            if xsol(j)>1e-2
                set(ar,'FaceColor',[0.85 0.15 0.15]);
            end
        else
            % Otherwise display the index for this purchase option
            annotation('textbox','Position',[x(j) y(2) x(j+1)-x(j) ywidth],...
                'String', ['x' num2str(j)],...
                'VerticalAlignment','middle', 'HorizontalAlignment','Center',...
                'EdgeColor','none');
        end
    end

    % Plot the index and expected returns for the other purchase options
    for i = 1:N
        j = PurchaseYears(i+T); % year of purchase
        Sidx = i+T; % purchase option index
        % Draw a rectangle for each purchase option that extends for the length
        % of the maturity period
        ar = annotation('rectangle','Position',[x(j) y(i+2) x(j+Maturity(Sidx))-x(j) ywidth],...
            'FaceColor', [0.8 0.8 0.8]);
        % If visualizing the solution
        if plotSol 
            % Add a textbox containing the amount invested
            annotation('textbox','Position',[x(j) y(i+2) x(j+Maturity(Sidx))-x(j) ywidth],...
                'String', ['x' num2str(Sidx) ' = ' num2str(xsol(Sidx),'%.2f')],...
                'VerticalAlignment','middle', 'HorizontalAlignment','Center',...
                'EdgeColor','none');
            % If the amount invested is not too small color the rectangle in
            % red
            if xsol(Sidx)>1e-2
                set(ar,'FaceColor',[0.85 0.15 0.15]);
            end
        else
            % Otherwise display the index for this purchase option
            annotation('textbox','Position',[x(j) y(i+2) x(j+Maturity(Sidx))-x(j) ywidth],...
                'String', ['x' num2str(Sidx)],...
                'VerticalAlignment','middle', 'HorizontalAlignment','Center',...
                'EdgeColor','none');
        end
    end
    
else % if large scale example
    % Plot the horizontal bond lines
    idx = xsol>1e-2;
    nsol = nnz(idx);
    xsec = NaN(3*nsol,1);
    xsec(1:3:end) = x(PurchaseYears(idx));
    xsec(2:3:end) = x(PurchaseYears(idx)+Maturity(idx));
    ysec = NaN(3*nsol,1);
    idx0 = idx(1:T);
    nsol0 = nnz(idx0);
    ysec(1:3:3*nsol0) = y(1);
    ysec(2:3:3*nsol0) = y(1);
    ysec(3*nsol0+1:3:end) = y(find(idx(T+1:end))+1);
    ysec(3*nsol0+2:3:end) = y(find(idx(T+1:end))+1);
    plot(xsec,ysec,'r','LineWidth',2)
    % Add textbox to label the solution bonds
    tidx = find([sum(idx0);idx(T+1:end)]);
    for i=1:nnz(tidx)
       annotation('textbox','Position',[xl y(tidx(i)) x(1)-xl ywidth],...
           'String',['B_{' num2str(tidx(i)-1) '}'],...
            'VerticalAlignment','Middle', 'HorizontalAlignment','Center',...
            'EdgeColor','none');
    end
    % Add textbox to label each year
    annotation('textbox','Position',[0 yt x(1) 0.98-yt],...
        'String', 'Year ',...
        'VerticalAlignment','Middle', 'HorizontalAlignment','Right',...
        'EdgeColor','none');
    for j=1:T
        annotation('textbox','Position',[x(j) yt xwidth 0.98-yt],...
            'String', num2str(j), 'FontSize', 8,...
            'VerticalAlignment','Middle', 'HorizontalAlignment','Center',...
            'EdgeColor','none');
    end
end

hold off