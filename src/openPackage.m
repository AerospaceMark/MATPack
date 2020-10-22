function openPackage(packageName)

    packageName = convertCharsToStrings(packageName);
    
    eval(strcat("cd ",userpath,filesep,packageName));

end