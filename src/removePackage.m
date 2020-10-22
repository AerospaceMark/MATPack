function removePackage(packageName)

    packageName = convertCharsToStrings(packageName);
    
    packagePath = strcat(userpath,filesep,packageName);
    
    if isfolder(packagePath)
        
        disp(strcat("Removing package ",packageName," at ",packagePath))
        eval(strcat("!rm -rf ",packagePath));
        
    else
        
        disp(strcat("Package ",packageName," not found at ",packagePath))
        
    end

end