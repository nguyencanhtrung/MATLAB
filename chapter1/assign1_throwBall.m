% define some constants
initHeight  = 1.5;
graAcc      = 9.8;
initVel     = 4;
initRad     = 45;

tVec        = linspace(0, 1, 1000);

% distance
x = initVel * cos(initRad * pi / 180) .* tVec;

% height
y = initHeight + initVel * sin(initRad * pi / 180) .* tVec - (graAcc .* tVec.^2) ./2;

% find index when  height = 0
indexMat = find(y < 0);
index = min(indexMat);
    %distance at that index
d = x(index);
disp(['The ball hits the ground at the distance of ' num2str(d) ' meters']);

% Plot the ball trajectory
figure;
plot(x, y, 'r');
xlabel('Distance (m)');
ylabel('Height (m)');
title('Ball trajectory');
    % plot ground dashed line
hold on;
plot([0, max(x)], [0 0], '--b');

