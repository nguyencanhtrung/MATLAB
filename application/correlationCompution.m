% Load indices
    format long;
    lamda = 0.94;
    totalDay = 256;

    fileName = 'data.xlsx';
    sheet    = 6;

    indexA = xlsread(fileName, sheet,'D15:D271');
    indexB = xlsread(fileName, sheet,'E15:E271');

    % 
    len        = length(indexA);
    retA_BRAM  = zeros(len, 1);
    retB_BRAM  = zeros(len, 1);
    weightROM  = zeros(len, 1);

    devtRetA   = zeros(len - 1, 1);
    devtRetB   = zeros(len - 1, 1);
    % 
% %Step 1:    Compute continously compounded rate of return
    disp('Step 1: Compute Log rate of return');
    tic;
    sumRetA = 0;
    retA_BRAM(len, 1) = 0;
    for n = len - 1 :-1 : 1
        retA_BRAM(n, 1) = log(indexA(n, 1)/indexA(n+1, 1));
        sumRetA = sumRetA + retA_BRAM(n, 1);
    end;
    toc;
   
    sumRetB = 0;
    retB_BRAM(len, 1) = 0;
    for n = len - 1 :-1 : 1
        retB_BRAM(n, 1) = log(indexB(n, 1)/indexB(n+1, 1));
        sumRetB = sumRetB + retB_BRAM(n, 1);
    end
    
% %Step 2:    Compute weight, and sum of weight -- Can be precomputed
    disp('Step 2: Compute Weight and its sum');
    tic;
    weightROM(1) = 1;
    sumWeight = 0;
    for n = 2 : len
        weightROM(n) = lamda * weightROM(n - 1);
        sumWeight    = sumWeight + weightROM(n);
    end
    toc;
    
%Step 3:    Compute MEAN of compounded rate of return
    disp('Step 3: Compute MEAN of return''s rate');
    tic;
    meanRetA = sumRetA/256;
    toc;
    meanRetB = sumRetB/256;
    
%Step 4:    Compute deviation of rate of return
    disp('Step 4: Compute DEVIATION of return''s rate');
    tic;
    for n = 1 : len - 1
        devtRetA(n) = retA_BRAM(n) - meanRetA;
    end
    toc;
    %
    for n = 1 : len - 1
        devtRetB(n) = retB_BRAM(n) - meanRetB;
    end

%Step 5:    Compute Volatility
    disp('Step 5: Compute Volatility');
    tic;
    sumVolA =0;
    for n = 1 : len -1
        sumVolA = devtRetA(n)^2 * weightROM(n) + sumVolA;
    end
    volaA = sqrt(sumVolA/sumWeight);
    toc;
    %
    sumVolB =0;
    for n = 1 : len -1
        sumVolB = devtRetB(n)^2 * weightROM(n) + sumVolB;
    end
    volaB = sqrt(sumVolB/sumWeight);
    
%Step 5:     Compute Covariance
    disp('Step 5: Compute Covariance');
    tic;
    sumCov = 0;
    for n = 1: len -1
        sumCov = devtRetA(n) * devtRetB(n) * weightROM(n) + sumCov;
    end
    covariance = sumCov/sumWeight;
    toc;
%Step 6:    Compute Correlation
    disp('Step 5: Compute Correlation');
    tic;
    correlation = covariance/(volaA * volaB);
    toc;
    