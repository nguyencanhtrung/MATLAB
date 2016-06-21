% function plotSin(f1)
% %PLOTSIN Summary of this function goes here
% %   Detailed explanation goes here
% % 1st exercise
% x     =  linspace(0, 2*pi, 30 * f1);
% y     =  sin(f1 * x);
% plot(x, y);
% xlabel('x (rad)');
% ylabel('sin(x)');
% title(['Sinusoidal with frequency f = ', num2str(f1)]);
% end

function plotSin(f1, f2)
% 2nd exercise
if nargin == 1
    x     =  linspace(0, 2*pi, 30 * f1);
    y     =  sin(f1 * x);
    plot(x, y, 'go-');
    xlabel('x (rad)');
    ylabel('sin(x)');
    title(['Sinusoidal with frequency f = ', num2str(f1)]);
elseif nargin == 2
    disp('Two inputs were given');
end
end