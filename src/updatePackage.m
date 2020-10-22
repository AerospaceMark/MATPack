function updatePackage(packageName)
    
    packageName = convertCharsToStrings(packageName);
    eval(strcat("!git -C ",userpath,filesep,packageName," pull"));

end