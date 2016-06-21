disp(['Hello World' ...
    'I am going to learn Matlab']);

% Get and save current date and time
start = clock;
sizeClock = size(start);
disp('size of clock is: ');
disp(sizeClock);

if sizeClock(1) == 1
    disp('It is a row matrix');
elseif sizeClock(2) == 1
    disp('It is a colum matrix');
end

% Conversion DATE Array to DATE STRING
startString = datestr(start);
save startTime startString start;
clear all;
    % Printing that date array as date string to command windows
load startTime;
disp(['I started learning MATLAB on ' ... 
    startString]);

    %fprintf('I started learning MATLAB on %s \n', startString);

% Apply built-in functions 
tau = 1.5 * 24 * 3600;
endOfClass = 5 * 24 * 3600;
knowledgeAtEnd = 1 - exp(-(endOfClass/tau));
fprintf('At the end of 6.094, I will know %s%% of MATLAB\n', num2str(knowledgeAtEnd * 100));
    %disp(['At the end of 6.094, I will know ' ...
    %    num2str(knowledgeAtEnd * 100) '% of MATLAB']);

% Working with matrices, vectors
a = [1 2 3 4+i];
transpose(a);
secPerMin = 60;
secPerHour = secPerMin * 60;
secPerDay = secPerHour * 24;
secPerMonth = secPerDay * 30.5;
secPerYear = secPerMonth * 12;

secondConversion =[secPerYear, secPerMonth, secPerDay, secPerHour, secPerMin, 1];
currentTime = clock;
elapsedTime = start - currentTime;
    %elapsedTime
t = secondConversion * transpose(elapsedTime);
    %t= secondConversion * elapsedTime';
    % knowledge
currentKnowledge = 1 - exp(-t/tau);
disp(['At this time, I know ' num2str(currentKnowledge * 100) '% of MATLAB']);

% Automatic Initialization
resolution = endOfClass / 10000;
tVec = linspace(0,endOfClass, 10000);
    %tVec = 0:resolution:endOfClass;
knowledgeVec = 1 - exp(-tVec./tau);

% Indexing
    % Find index where knowledgeVec is closet to 0.5
[val, ind] = min(abs(knowledgeVec - 0.5));
    % half of time in sec
halfTime = tVec(ind);
disp(['I know half of MATLAB after' num2str(halfTime/secPerDay) ' days']);

% plot the learning trajectory
plot(tVec/secPerDay, knowledgeVec);

   