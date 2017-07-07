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

indexA_hex = zeros(252, 1);

indexA_hex = num2hex(single(indexA));
indexB_hex = num2hex(single(indexB));
indexC_hex = num2hex(single(indexC));
indexE_hex = num2hex(single(indexE));
indexF_hex = num2hex(single(indexF));

for i = 1 : 252
    address = dec2hex(hex2dec('11000000') + (i - 1) * 4);
%     value   = indexA_hex(i, :);
%     display(['mwr 0x' num2str(address) ' 0x' num2str(value)]);
end
disp('    ----');
initial_address = address;
for i = 1 : 252
    address = dec2hex(hex2dec(initial_address) + i * 4);
%     value = indexB_hex(i, :);
%     display(['mwr 0x' num2str(address) ' 0x' num2str(value)]);
end
disp('    ----');

initial_address = address;
for i = 1 : 252
    address = dec2hex(hex2dec(initial_address) + i * 4);
    value = indexC_hex(i, :);
    display(['mwr 0x' num2str(address) ' 0x' num2str(value)]);
end
disp('    ----');

initial_address = address;
for i = 1 : 252
    address = dec2hex(hex2dec(initial_address) + i * 4);
    value = indexE_hex(i, :);
    display(['mwr 0x' num2str(address) ' 0x' num2str(value)]);
end
disp('    ----');

initial_address = address;
for i = 1 : 252
    address = dec2hex(hex2dec(initial_address) + i * 4);
    value = indexF_hex(i, :);
    display(['mwr 0x' num2str(address) ' 0x' num2str(value)]);
end