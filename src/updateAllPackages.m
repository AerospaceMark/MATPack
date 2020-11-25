% Purpose: To update all of the packages in your user path

function updateAllPackages()
    
    disp(' ')
    disp('Updating all packages...')
    disp(' ')

    directoryInfo = dir(userpath);
    for i = 1:length(directoryInfo)
        
        path = strcat(userpath,filesep,directoryInfo(i).name);
        
        if isfolder(strcat(path,filesep,'.git'))
            disp(strcat("Updating the '",directoryInfo(i).name,"' package."))
            updatePackage(directoryInfo(i).name)
        end
        
    end
    
    disp(' ')
    disp('Done updating all packages.')
    disp(' ')

end