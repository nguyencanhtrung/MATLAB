function [ correlation ] = correlationCompFunct(indexA, indexB)
%CORRECOMP Summary of this function goes here
%   Detailed explanation goes here
    % 
    format long;
    lamda = 0.94;
    %totalDay = 256;
    
    len        = length(indexA);
    retA_BRAM  = zeros(len, 1);
    retB_BRAM  = zeros(len, 1);
    weightROM  = zeros(len, 1);

    devtRetA   = zeros(len - 1, 1);
    devtRetB   = zeros(len - 1, 1);
    % 
% %Step 1:    Compute continously compounded rate of return
    sumRetA = 0;
    retA_BRAM(len, 1) = 0;
    for n = len - 1 :-1 : 1
        retA_BRAM(n, 1) = log(indexA(n, 1)/indexA(n+1, 1));
        sumRetA = sumRetA + retA_BRAM(n, 1);
    end;
   
    sumRetB = 0;
    retB_BRAM(len, 1) = 0;
    for n = len - 1 :-1 : 1
        retB_BRAM(n, 1) = log(indexB(n, 1)/indexB(n+1, 1));
        sumRetB = sumRetB + retB_BRAM(n, 1);
    end
    
% %Step 2:    Compute weight, and sum of weight -- Can be precomputed
    weightROM(1) = 1;
    sumWeight = 0;
    for n = 2 : len
        weightROM(n) = lamda * weightROM(n - 1);
        sumWeight    = sumWeight + weightROM(n);
    end
    
%Step 3:    Compute MEAN of compounded rate of return
    meanRetA = sumRetA/256;
    meanRetB = sumRetB/256;
    
%Step 4:    Compute deviation of rate of return
    for n = 1 : len - 1
        devtRetA(n) = retA_BRAM(n) - meanRetA;
    end
    %
    for n = 1 : len - 1
        devtRetB(n) = retB_BRAM(n) - meanRetB;
    end

%Step 5:    Compute Volatility
    sumVolA =0;
    for n = 1 : len -1
        sumVolA = devtRetA(n)^2 * weightROM(n) + sumVolA;
    end
    volaA = sqrt(sumVolA/sumWeight);
    %
    sumVolB =0;
    for n = 1 : len -1
        sumVolB = devtRetB(n)^2 * weightROM(n) + sumVolB;
    end
    volaB = sqrt(sumVolB/sumWeight);
    
%Step 5:     Compute Covariance
    sumCov = 0;
    for n = 1: len -1
        sumCov = devtRetA(n) * devtRetB(n) * weightROM(n) + sumCov;
    end
    covariance = sumCov/sumWeight;

%Step 6:    Compute Correlation
    correlation = covariance/(volaA * volaB);
end

