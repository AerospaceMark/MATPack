% Purpose: take all of the packages in the userpath and set them to the
% master branch

function setAllToMaster()

    directoryInfo = dir(userpath);
    
    for i = 1:length(directoryInfo)
        
        path = strcat(userpath,filesep,directoryInfo(i).name,filesep,'.git');
        
        if isfolder(path)
            eval(strcat("!git -C ",userpath,filesep,directoryInfo(i).name," checkout master -q"))
            disp(strcat("Set the ",directoryInfo(i).name,"package to master."))
        end
        
    end

end