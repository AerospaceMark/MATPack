% Purpose: To do a 'pull' on any package that is connected to an online Git
% repository

function updatePackage(packageName)
    
    packageName = convertCharsToStrings(packageName);
    eval(strcat("!git -C ",userpath,filesep,packageName," pull"));

end