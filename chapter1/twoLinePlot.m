figure;
t = linspace(0, 2*pi, 1000);
plot(t, sin(t));
hold on;    % keep previous plot
plot(t, cos(t), 'g');

% label figure, x, y axis and legend
xlabel('Time(s)');
ylabel('Function');
title('Sin and Cosin');
legend('sin(t)', 'cos(t)');

% set limit for x and y axis
xlim([0, 2*pi]);
ylim([-1.4, 1.4]);