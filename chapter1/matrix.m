% Matrices operators and accessing
% colon operator   ":"
a = 1:3;
    % a = [1 2 3]
b = 1:2:5;
    % b = [1 3 5]
c = colon(1, 4);
    % c = [1 2 3 4]    same as c = 1:4
% keyword  "end"
    
% Accessing part of Matrix


% Combining Matrices
A1 = [1 1 1; 1 1 1];
A2 = [2 2 2; 2 2 2];
A3 = [3 3 3; 3 3 3];
    
A = [A1 A2 A3];
A = [A1; A2; A3];

% Transposition using operator '
H = [1 2 3; 4 5 6];
G = H';
    % or
G = transpose(H);

1:2:5';         % wrong, it transposes 5 first
(1:2:5)';       % correct

% Array multiplication # Matrix multiplication
    % Array multiplication is somehow like element-wise multiplication
    % Using operator ".*"
    A = [1:3; 4:6]
    B = [2:4; 5:7]
    C = A.*B
    
    % Matrix multiplication: using operator "*" , another name is dot
    % product.
    % Matrix multiplication must full fill condition about the size of 2
    % matrices' operands.    mxn  * nxl = mxl
    E = rand(2,5);
    D = rand(5,4);
    F = E * D;
    
% Array division (2 types); will not talk about matrix division
    % X./Y (over)   -- Element-wise division
    X = [1 4 ; 7 1; 5 5];
    Y = [2 -4; 6 2; 1 3];
    Z =X./Y;
    
    %X.\Y (under)  -- Equivalent to Y./X
    M = Y.\X;
    
% Exponentiation
    % Element-wise           .^
        A = [1 2; 3 4];
        B = [1 2; 3 4];
        C =  A.^B;
    % Matrix exponentiation   ^
        A^3;   % = A * A * A
