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

logA = zeros(251, 1);
logB = zeros(251, 1);
logC = zeros(251, 1);
logE = zeros(251, 1);
logF = zeros(251, 1);

indexA_hex = num2hex(single(indexA));
indexB_hex = num2hex(single(indexB));
indexC_hex = num2hex(single(indexC));
indexE_hex = num2hex(single(indexE));
indexF_hex = num2hex(single(indexF));

% log computation
for n = 1: 251
    logA(n) = log(indexA(n)/ indexA(n+1)); 
    logB(n) = log(indexB(n)/ indexB(n+1)); 
    logC(n) = log(indexC(n)/ indexC(n+1)); 
    logE(n) = log(indexE(n)/ indexE(n+1)); 
    logF(n) = log(indexF(n)/ indexF(n+1));  
end

logA_hex =  num2hex(single(logA));
logB_hex =  num2hex(single(logB));
logC_hex =  num2hex(single(logC));
logE_hex =  num2hex(single(logE));
logF_hex =  num2hex(single(logF));

% weight computation
weightROM           = zeros(251, 1);
weightROM(1)        = 1;
sumWeight           = 1;
for n = 2 : 251
    weightROM(n)    = lamda * weightROM(n - 1);
    sumWeight       = sumWeight + weightROM(n);
end

weight_hex = num2hex(single(weightROM));

sumWeight_hex = num2hex(single(sumWeight));

% log * weight
logA_weight      = zeros(251,1);
logB_weight      = zeros(251,1);
logC_weight      = zeros(251,1);
logE_weight      = zeros(251,1);
logF_weight      = zeros(251,1);

for n = 1: 251
   logA_weight(n)   = logA(n) * weightROM(n); 
   logB_weight(n)   = logB(n) * weightROM(n); 
   logC_weight(n)   = logC(n) * weightROM(n); 
   logE_weight(n)   = logE(n) * weightROM(n); 
   logF_weight(n)   = logF(n) * weightROM(n); 
end

logA_weight_hex      = num2hex(single(logA_weight));
logB_weight_hex      = num2hex(single(logB_weight));
logC_weight_hex      = num2hex(single(logC_weight));
logE_weight_hex      = num2hex(single(logE_weight));
logF_weight_hex      = num2hex(single(logF_weight));