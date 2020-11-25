% Purpose: To determine the name of the current package

function packageName = getCurrentPackage()

    currentPath = pwd();
    
    fullPackageName = currentPath(length(userpath) + 2:end);
    
    separators = strfind(fullPackageName,filesep);
    
    if length(separators) > 0 % If there is a separator
        packageName = fullPackageName(1:separators(1)-1);
    else
        packageName = fullPackageName(1:end);
    end

end