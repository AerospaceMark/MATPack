function removePackage(packageName)

    packageName = convertCharsToStrings(packageName);
    
    packagePath = strcat(userpath,filesep,packageName);
    
    if isfolder(packagePath)
        
        disp(strcat("Removing package ",packageName," at ",packagePath))
        if ismac % If you're running macOS
            eval(strcat("!rm -rf ",packagePath));
        else % If you're running windows
            disp("Sorry, removing packages doesn't work yet on Windows computers.")
            disp("Please delete the package manually.")
        end
        
    else
        
        disp(strcat("Package ",packageName," not found at ",packagePath))
        
    end

end