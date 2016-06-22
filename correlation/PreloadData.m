%% Preload data from internet (Yahoo)
%stocks = hist_stock_data('01012000','31122009','msft','ibm');

% fileName = 'data.xlsx';
% sheet    = 6;
% 
% indexA = xlsread(fileName, sheet,'D15:D271');
% indexB = xlsread(fileName, sheet,'E15:E271');

stocks = hist_stock_data('12062015','20062016','msft','ibm');
stock1=flipud(stocks(1).AdjClose(end:-1:1))
stock2=flipud(stocks(2).AdjClose(end:-1:1));

% y1 = diff(log(stock1)); % convert prices to returns
% y2 = diff(log(stock2));
% y1 = y1(15:end,:); % length adjustment
% y2 = y2(15:end,:);
% y = [y1 y2];
tic;
correlationCompFunct(stock1, stock2)
toc;
% correlationComp(indexA, indexB)

%T = length(y1)
%value = 1000; % portfolio value
%p = 0.01; % probability
%w = [0.3; 0.7]