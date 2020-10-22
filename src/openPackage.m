% Purpose: change the current MATLAB directory to be within the specified
% package

function openPackage(packageName)

    packageName = convertCharsToStrings(packageName);
    
    eval(strcat("cd ",userpath,filesep,packageName));

end