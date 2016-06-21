load assign1_classGrades;
grades          = namesAndGrades(:,2:end);
grades(1:5, :)
meanGrades      = nanmean(grades)
    % create mean matrix size of 15 x 7
meanMatrix      = ones([15 1]);
meanMatrix      = meanMatrix * meanGrades
meanMatrix'
    % normalize all grades to 3.5
curvedGrades    = 3.5 * (grades./meanMatrix);
    % check mean of curvedGrades - all = 3.5
nanmean(curvedGrades)
index           = find(curvedGrades > 5);
curvedGrades(index) = 5;

    % compute total grades
totalGrades     = ceil(nanmean(curvedGrades,2));

    % Display text format
letter          = ['F' 'D' 'C' 'B' 'A'];
letterGrades    = letter(totalGrades);
disp(letterGrades);