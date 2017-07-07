% Load data from excel file
fileName    = 'data.xlsx';
sheet       = 6;
indexA      = xlsread(fileName, sheet,'D15:D25'); %271
indexB      = xlsread(fileName, sheet,'E15:E25');
indexC      = xlsread(fileName, sheet,'P15:P25');
indexD      = xlsread(fileName, sheet,'AA15:AA25');
indexE      = xlsread(fileName, sheet,'AL15:AL25');
indexF      = xlsread(fileName, sheet,'');

input       = [indexA'; indexB'; indexC'; indexD'; indexE'];
%save inputData input;
% input = 1:1:1285;

fileID = fopen('inputData2.dat','w');
fprintf(fileID,'%f\n', input');
fclose(fileID);