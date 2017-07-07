%-------------------------------------------------------------------------%
% TU Kaiserslautern - Microelectronics                                    %
% Author: Trung C. Nguyen                                                 %
% Master Thesis: Financial Correlation Computation                        %
% File: main.m                                                            %
% Revision:                                                               %
%       - v0.01: File Creation - July, 2016                               %
%                Using the first implementation architecture              %
%                N = 1000   - Time = 32.9919 s, 36.3006s                  %
%                N = 2000   - Time =                                      %
%                N = 10000  - Time =  ~1.0085h                            %
%       - v0.02: Using the second implementation architecture             %
%                N = 1000   - Time =  25.8167 s, 28.586s                  %
%                N = 2000   - Time =                                      %
%                N = 10000  - Time =  ~ 0.783h                            %
%-------------------------------------------------------------------------%
% % Testing parameters
number_of_indices   = 1000 ;
num_testing         = 100;
%---------------------------
number_of_cal       = ((number_of_indices - 1) * number_of_indices)/2;
num_indices         = 10000;
% Load indices
format long;
lamda = 0.94;
totalDay = 252;

fileName = 'data.xlsx';
sheet    = 6;

indexA              = xlsread(fileName, sheet,'D15:D266');
indexB              = xlsread(fileName, sheet,'E15:E266');
indexC              = xlsread(fileName, sheet,'P15:P266');
indexE              = xlsread(fileName, sheet,'AA15:AA266');
indexF              = xlsread(fileName, sheet,'AL15:AL266');
index_original      = vertcat(indexA, indexB, indexC, indexE, indexF);
indices             = index_original;
% Create sample data
for n = 1 : 1999
    indices         = vertcat(indices, index_original);
end
% Compute weight, and sum of weight -- Can be precomputed
weightROM           = zeros(totalDay - 1, 1);
weightROM(1)        = 1;
sumWeight           = 1;
for n = 2 : totalDay - 1
    weightROM(n)    = lamda * weightROM(n - 1);
    sumWeight       = sumWeight + weightROM(n);
end

display(['Times to compute correlations of ' ...
          num2str(number_of_indices) ' indices']);

% % Main function v1
tic;
for t = 1 : num_testing
    for n = 1 : (number_of_indices - 1)
        index1          = indices(((n - 1) * totalDay + 1): ...
                                    ((n - 1) * totalDay + totalDay));
        for i = n + 1 : number_of_indices
            index2 = indices( ((i - 1) * totalDay + 1): ...
                                ((i - 1) * totalDay + totalDay)  );
            correlation = correlationCompFunct_v1(  index1, ...
                                                    index2, ...
                                                    weightROM, ...
                                                    sumWeight);
        end
    end
end
totalTime_v1 = toc;
display(['Total time v1 = ' num2str(totalTime_v1/num_testing) ' s']);

% % Main function v2
tic;
for t = 1 : num_testing
    for n = 1 : (number_of_indices - 1)
        index1 = indices(((n - 1) * totalDay + 1): ...
                                ((n - 1) * totalDay + totalDay));
        for i = n + 1 : number_of_indices
            index2 = indices( ((i - 1) * totalDay + 1): ... 
                                ((i - 1) * totalDay + totalDay)  );
            correlation = correlationCompFunct_v2(  index1, ...
                                                    index2, ...
                                                    weightROM, ...
                                                    sumWeight);
        end
    end
end
totalTime_v2 = toc;

display(['Total time v2 = ' num2str(totalTime_v2/num_testing) ' s']);
    