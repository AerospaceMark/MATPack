% Purpose: take all of the packages in the userpath and set them to the
% master branch

function setAllToMaster()

    disp(' ')
    disp("Setting all packages to 'master'...")
    disp(' ')

    directoryInfo = dir(userpath);
    
    for i = 1:length(directoryInfo)
        
        path = strcat(userpath,filesep,directoryInfo(i).name,filesep,'.git');
        
        if isfolder(path)
            disp(strcat("Setting the '",directoryInfo(i).name,"' package to master."))
            eval(strcat("!git -C ",userpath,filesep,directoryInfo(i).name," checkout master -q"))
        end
        
    end
    
    disp(' ')
    disp("Done setting all packages to 'master'.")
    disp(' ')

end