%-------------------------------------------------------------------%
% TU Kaiserslautern - Microelectronics                              %
% Author: Trung C. Nguyen                                           %
% Master Thesis: Financial Correlation Computation                  %
% File: correlationCompFunct_v1.m                                   %
% Revision:                                                         %
%       - v0.01: File Creation - July, 2016                         %
%                Using the first implementation architecture        %
%       - v0.02: Using the improved architecture                    %
%-------------------------------------------------------------------%
function [ correlation ] = correlationCompFunct_v2(indexA, indexB, ...
                                                   weightROM, sumWeight)
    
    len                     = length(indexA);

%Step 1:    Compute continously compounded rate of return
    sumRetA                 = 0.0;
    sumRetB                 = 0.0;
    sum_weight_retA         = 0.0;
    sum_weight_retB         = 0.0;
    sum_weight_ret2A        = 0.0;
    sum_weight_ret2B        = 0.0;
    sum_weight_retA_retB    = 0.0;
    
    for n = 1 : (len - 1)
        retA                = log(indexA(n, 1)/indexA(n+1, 1));
        retB                = log(indexB(n, 1)/indexB(n+1, 1));
        
        sumRetA             = sumRetA + retA;
        sumRetB             = sumRetB + retB;
        
        sum_weight_retA     = sum_weight_retA + retA * weightROM(n);
        sum_weight_retB     = sum_weight_retB + retB * weightROM(n);
        
        sum_weight_ret2A    = sum_weight_ret2A + retA * retA * weightROM(n);
        sum_weight_ret2B    = sum_weight_ret2B + retB * retB * weightROM(n);
        
        sum_weight_retA_retB = sum_weight_retA_retB + retA * retB * weightROM(n);
    end;
    
%Step 2:    Compute MEAN of compounded rate of return
    meanRetA                = sumRetA/ (len - 1);
    meanRetB                = sumRetB/ (len - 1);
    
%Step 3:    Compute Volatility
    volaA                   = sqrt( (sum_weight_ret2A - 2 * sum_weight_retA * meanRetA)/sumWeight + (meanRetA * meanRetA));
    %
    volaB                   = sqrt((sum_weight_ret2B - 2 * sum_weight_retB * meanRetB)/sumWeight + meanRetB * meanRetB);
    
%Step 4:     Compute Covariance
    covariance              = (sum_weight_retA_retB - meanRetA * sum_weight_retB - meanRetB * sum_weight_retA) /sumWeight + (meanRetA * meanRetB);

%Step 5:    Compute Correlation
    correlation             = covariance/(volaA * volaB);
end

