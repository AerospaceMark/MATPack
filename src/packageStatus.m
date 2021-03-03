% Purpose: check the current status of a package

function packageStatus(packageName)

    packageName = convertCharsToStrings(packageName);
    
    command = strcat("git -C ",userpath,filesep,packageName," status");
    
    [successFlag, output] = runSystemCommand(command,true);
        
    if ~successFlag

        disp('Error while checking the package status. System output is:')
        disp(output)

    end

end