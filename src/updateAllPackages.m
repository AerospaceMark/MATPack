% Purpose: To update all of the packages in your user path

function updateAllPackages()

    directoryInfo = dir(userpath);
    for i = 1:length(directoryInfo)
        
        path = strcat(userpath,filesep,directoryInfo(i).name);
        
        if isfolder(strcat(path,filesep,'.git'))
            updatePackage(directoryInfo(i).name)
        end
        
    end

end