% problem 1
a = 10;
b = 2.5 * 10^23;
c = 2 + 3*i;
d = exp(j*2*pi/3);

% problem 2
aVec = [3.14 15 9 26];
bVec = [2.71; 8; 28; 182];
cVec = [5: -0.2: -5];
dVec = logspace(0, 1, 101);
eVec = ['Hello'];

% problem 3a
aMat = ones(9);
aMat = aMat + 1;
    %or
    %aMat = zeros(9);
    %aMat = aMat + 2;
% prob 3b
v = [1 2 3 4 5 4 3 2 1];
bMat = diag(v)
% prob 3c
v = [1:1:100];
cMat = reshape(v,[10, 10]);
% prob 3d
dMat = nan(3,4);
%prob 3e
eMat = [[13 -1 5]; [-22 10 -87]];
%prob 3f
fMat = -3 + floor((3 + 3) * rand(5,3));

% problem 4
x = 1/(1 + exp(-(a-15)/6));
y = (sqrt(a) + nthroot(b, 21))^pi;
z = (log(real((c+d)*(c-d)) * sin(a*pi/3)))/(c*conj(c));

% problem 5
xVec = (1/sqrt(2*pi*2.5^2)) * exp(-(cVec.^2)/(2*2.5^2));
yVec = sqrt((transpose(aVec)).^2 + bVec.^2);
zVec = log10(1./dVec);

% problem 6
xMat = (aVec * bVec) * aMat.^2;
yMat = bVec * aVec;
zMat = det(a) * transpose(aMat * bMat);

% problem 7
cSum = sum(cMat);
eMean = mean(eMat,2);
eMat(1,:) = [1 1 1];
cSub = cMat(2:9, 2:9);
    %e
lin = [1:1:20];
coef = (-1).^(lin + 1);
lin = coef .*lin;
        %or
        %lin = [1:1:20];
        %index = find(mod(lin, 2) == 0);
        %lin(index) = -1 * lin(index);
    %f
r = rand(1,5);
index = find(r < 0.5);
r(index) = 0;