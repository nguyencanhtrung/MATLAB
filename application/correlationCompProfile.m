
% Load indices
    format long;
    lamda       = 0.94;
    totalDay    = 256;
        % Load data from excel file
    fileName    = 'data.xlsx';
    sheet       = 6;
    indexA      = xlsread(fileName, sheet,'D15:D266');
    indexB      = xlsread(fileName, sheet,'E15:E266');

        % Instantiation
    len         = length(indexA);
    retA_BRAM   = zeros(len, 1);
    retB_BRAM   = zeros(len, 1);
    weightROM   = zeros(len, 1);

    devtRetA    = zeros(len - 1, 1);
    devtRetB    = zeros(len - 1, 1);
    
% %Step 1:    Compute continously compounded rate of return
    disp('Step 1: Compute Log rate of return');
    tic;
    sumRetA             = 0;
    retA_BRAM(len, 1)   = 0;
        % -- 1 log and 1 division
    for n = len - 1 :-1 : 1
        retA_BRAM(n, 1) = log(indexA(n, 1)/indexA(n+1, 1));
        sumRetA         = sumRetA + retA_BRAM(n, 1);
    end;
        % -- Alternative way  (1 log and 1 substraction)
%     temp1 = log(indexA(n + 1, 1));
%     temp2 = 0;
%     for n = len - 1 :-1 : 1
%         temp2             = log(indexA(n,1));
%         retA_BRAM(n, 1)   = temp2 - temp1;
%         temp1             = temp2;
%         sumRetA           = sumRetA + retA_BRAM(n, 1);
%     end;
    timeReturnA         = toc;
    %
    tic;
    sumRetB             = 0;
    retB_BRAM(len, 1)   = 0;
    for n = len - 1 :-1 : 1
        retB_BRAM(n, 1) = log(indexB(n, 1)/indexB(n+1, 1));
        sumRetB         = sumRetB + retB_BRAM(n, 1);
    end
    timeReturnB         = toc;
    
% %Step 2:    Compute weight, and sum of weight -- Can be precomputed
    disp('Step 2: Compute Weight and its sum');
    tic;
    weightROM(1)        = 1;
    sumWeight           = 0;
    for n = 2 : len
        weightROM(n)    = lamda * weightROM(n - 1);
        sumWeight       = sumWeight + weightROM(n);
    end
    timeLambda          = toc;
    
%Step 3:    Compute MEAN of compounded rate of return
    disp('Step 3: Compute MEAN of return''s rate');
    tic;
    meanRetA            = sumRetA/256;
    timeMeanA           = toc;
    %
    tic;
    meanRetB            = sumRetB/256;
    timeMeanB           = toc;
    
%Step 4:    Compute deviation of rate of return
    disp('Step 4: Compute DEVIATION of return''s rate');
    tic;
    for n = 1 : len - 1
        devtRetA(n)     = retA_BRAM(n) - meanRetA;
    end
    timeDevA            = toc;
    %
    tic;
    for n = 1 : len - 1
        devtRetB(n)     = retB_BRAM(n) - meanRetB;
    end
    timeDevB            = toc;
    
%Step 5:    Compute Volatility
    disp('Step 5: Compute Volatility');
    tic;
    sumVolA             = 0;
    for n = 1 : len -1
        sumVolA         = devtRetA(n)^2 * weightROM(n) + sumVolA;
    end
    volaA               = sqrt(sumVolA/sumWeight);
    timeVolA            = toc;
    %
    tic;
    sumVolB             = 0;
    for n = 1 : len -1
        sumVolB         = devtRetB(n)^2 * weightROM(n) + sumVolB;
    end
    volaB               = sqrt(sumVolB/sumWeight);
    timeVolB            = toc;
    
%Step 5:     Compute Covariance
    disp('Step 5: Compute Covariance');
    tic;
    sumCov              = 0;
    for n = 1: len -1
        sumCov          = devtRetA(n) * devtRetB(n) * weightROM(n) + ...
                          sumCov;
    end
    covariance          = sumCov/sumWeight;
    timeCov             = toc;
    
%Step 6:    Compute Correlation
    disp('Step 5: Compute Correlation');
    tic;
    correlation = covariance/(volaA * volaB);
    timeCorrelation = toc;
    display('----------------------------------');
    display(correlation);
    display('----------------------------------');
% Profiling
% totalTime = timeReturnA + timeReturnB + ...
%             timeMeanA + timeMeanB + ...
%             timeDevA + timeDevB + ...
%             timeVolA + timeVolB + ...
%             timeCov + timeCorrelation;
%             %timeLambda + ...
totalTime = timeReturnA + ...
            timeMeanA   + ...
            timeDevA    + ...
            timeVolA    + ...
            timeCov + timeCorrelation;
display('Times for 1 index calculation');
display(['Total time = ' num2str(totalTime) ' s']);
display(['Log return A  = ' num2str(timeReturnA/totalTime * 100, '%.3f') ' %']);
%display(['Log return B  = ' num2str(timeReturnB/totalTime * 100, '%.3f') ' %']);
%display(['Lambda        = ' num2str(timeLambda/totalTime * 100, '%.3f') '
%%']); >> Store in ROM - precomputed
display(['Mean A        = ' num2str(timeMeanA/totalTime * 100, '%.3f') ' %']);
%display(['Mean B        = ' num2str(timeMeanB/totalTime * 100, '%.3f') ' %']);
display(['Deviation A   = ' num2str(timeDevA/totalTime * 100, '%.3f') ' %']);
%display(['Deviation B   = ' num2str(timeDevB/totalTime * 100, '%.3f') ' %']);
display(['Volatility A  = ' num2str(timeVolA/totalTime * 100, '%.3f') ' %']);
%display(['Volatility B  = ' num2str(timeVolB/totalTime * 100, '%.3f') ' %']);
display(['Covariance    = ' num2str(timeCov/totalTime * 100, '%.3f') ' %']);
display(['Correlation   = ' num2str(timeCorrelation/totalTime * 100, '%.3f') ' %']);
display('----------------------------------');
display('----------------------------------');
X       = [timeReturnA/totalTime, timeMeanA/totalTime, timeDevA/totalTime, ...
            timeVolA/totalTime, timeCov/totalTime, timeCorrelation/totalTime];
lables  = {'Log return: '; 'Mean: '; 'Deviation: '; 'Volatility: '; 'Covarance: '; 'Correlation: '};
explode = [0, 0 , 0, 0, 0, 0];
h = pie(X);
    % store percentage value 
hText = findobj(h,'Type','text');           % text object handles
percentValues = get(hText,'String');        % percent values
    % combine percentage and string
combinedstrings = strcat(lables, percentValues);
    % Read Extent property of htext object
oldExtents_cell = get(hText,'Extent');      % cell array
    % Convert from cell to matrix
oldExtents = cell2mat(oldExtents_cell);     % numeric array
hText(1).String = combinedstrings(1);
hText(2).String = combinedstrings(2);
hText(3).String = combinedstrings(3);
hText(4).String = combinedstrings(4);
hText(5).String = combinedstrings(5);
hText(6).String = combinedstrings(6);