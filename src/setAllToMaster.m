% Purpose: take all of the packages in the userpath and set them to the
% master branch

function setAllToMaster()

    directoryInfo = dir(userpath);
    
    for i = 1:length(directoryInfo)
        
        path = strcat(userpath,filesep,directoryInfo(i).name,filesep,'.git');
        
        if isfolder(path)
            usePackage(directoryInfo(i).name,'master')
        end
        
    end

end