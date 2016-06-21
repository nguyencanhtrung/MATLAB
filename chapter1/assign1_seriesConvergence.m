p =  0.99;
k =  0:1:1000;

geomSeries = p.^k;
G = 1/(1 - p);

    % plot horizontal line
plot([0, max(k)], [G G],'r');
hold on

cumSum = cumsum(geomSeries);
plot(cumSum,'b');
xlim([0 ,max(k)]);
ylim([0, 114]);

legend('Infinite sum', 'Finite sum');
xlabel('No samples');
ylabel('Sum');
title('series convergen p = 0.99')

%
p = 2;
n = 1:1:500;
pSeries = 1./(n.^p);

figure
P = pi^2/6;
plot([0, max(n)], [P P],'r');
hold on

cumSum = cumsum(pSeries);
plot(cumSum,'b');
xlim([0 ,max(n)]);
%ylim([0, 114]);

legend('Infinite sum', 'Finite sum');
xlabel('Index');
ylabel('Sum');
title('series convergen p = 2')
