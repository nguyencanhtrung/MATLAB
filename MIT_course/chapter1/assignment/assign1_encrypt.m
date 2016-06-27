original = 'This is my top secret message';

% random permute indices of string
len     = length(original);
    % encoded indices
enIndices = randperm(len);
encoded = original(enIndices);

% Finding decoding key
indMat  = 1:1:len;
tempMat(:,1) = enIndices';
tempMat(:,2) = indMat';

    % sort
tempMat = sortrows(tempMat, 1);
    % decoded indices
deIndices = tempMat(:, 2);
decoded = encoded(deIndices);

% display
disp(['Original: ' original]);
disp(['Encoded: ' encoded]);
disp(['Decoded: ' decoded]);

% compare str
correct = strcmp(original, decoded);

row1 = 'False';
row2 = 'True ';
status = [row1; row2];
disp(['Decoded correctly: ' status(correct + 1, :)]);

