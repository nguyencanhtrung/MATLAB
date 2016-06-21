a           = zeros(2,4,8); % Create matrix 2x4x8
D           = size(a);      % Find size of matrix D = 2 4 8
[m,n]       = size(a);      % Find size in 2D form: m = 2; n = 4x8
[x, y, z]   = size(a);      % Find size in 3D form x = 2; y = 4; z = 8
m2          = size(a,2);    % Find size of the second dimension a = 4

%"varargin" is an INPUT VARIABLE
% >> function nameFunction(x, y, varargin)
% Remember: varargin must be put at the last position
% "varargin" is 1xN array, N is numbers of input

%"nargin" is number of input argument of current function
% if "varargin" is in the input argument => nargin return negative number


function [sum] = sumComp(x, y)
    sum = x + y;
end