%-------------------------------------------------------------------------%
% TU Kaiserslautern - Microelectronics                                    %
% Author: Trung C. Nguyen                                                 %
% Master Thesis: Financial Correlation Computation                        %
% File: correlationCompFunct_v1.m                                         %
% Revision:                                                               %
%       - v0.01: File Creation - July, 2016                               %
%                Using the first implementation architecture              %
%-------------------------------------------------------------------------%
function [ correlation ] = correlationCompFunct_v1(indexA, indexB, ...
                                                    weightROM, sumWeight)
    % 
    len        = length(indexA);     %len = totalDay = 252
    retA_BRAM  = zeros(len - 1, 1);
    retB_BRAM  = zeros(len - 1, 1);
    % 
% %Step 1:    Compute continously compounded rate of return
    sumRetA = 0;
    sumRetB = 0;
    retA_BRAM(len - 1, 1) = 0;
    retB_BRAM(len - 1, 1) = 0;
    for n = len - 1 :-1 : 1
        retA_BRAM(n, 1) = log(indexA(n, 1)/indexA(n+1, 1));
        retB_BRAM(n, 1) = log(indexB(n, 1)/indexB(n+1, 1));
        sumRetA = sumRetA + retA_BRAM(n, 1);
        sumRetB = sumRetB + retB_BRAM(n, 1);
    end;
    
%Step 2:    Compute MEAN of compounded rate of return
    meanRetA = sumRetA/ (len - 1);
    meanRetB = sumRetB/ (len - 1);
    
%Step 3:    Compute Volatility and Covariance
    sumVolA =   0;
    sumVolB =   0;
    sumCov  =   0;

    for n = 1 : len - 1
        devRetA     = retA_BRAM(n) - meanRetA;
        devRetB     = retB_BRAM(n) - meanRetB;
        sumVolA =  devRetA^2 * weightROM(n) + sumVolA;
        sumVolB =  devRetB^2 * weightROM(n) + sumVolB;
        sumCov  =  devRetA   * devRetB   * weightROM(n) + sumCov;
    end

    volaA = sqrt(sumVolA/sumWeight);
    volaB = sqrt(sumVolB/sumWeight);
    covariance = sumCov/sumWeight;

%Step 6:    Compute Correlation
    correlation = covariance/(volaA * volaB);
end

