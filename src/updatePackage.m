% Purpose: To do a 'pull' on any package that is connected to an online Git
% repository

function updatePackage(packageName)
    
    packageName = convertCharsToStrings(packageName);
    command = strcat("git -C ",userpath,filesep,packageName," pull");
    
    [successFlag, output] = runSystemCommand(command,false);
        
    if ~successFlag

        disp('Error while updating the package. System output is:')
        disp(output)

    end

end