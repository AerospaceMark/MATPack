% Purpose: to push any commits you have made to an online Git repository

function pushPackage(packageName)

    packageName = convertCharsToStrings(packageName);
    
    eval(strcat("!git -C ",userpath,filesep,packageName," push"));

end