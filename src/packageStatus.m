% Purpose: check the current status of a package

function packageStatus(packageName)

    packageName = convertCharsToStrings(packageName);
    
    eval(strcat("!git -C ",userpath,filesep,packageName," status"));

end