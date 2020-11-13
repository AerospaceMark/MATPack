% Purpose: create a new branch of a package

function createNewBranch(packageName,branchName,includeRemote)

    if nargin < 3
        includeRemote = true;
    end

    if isfolder(strcat(userpath,filesep,packageName))
        
        eval(strcat("!git -C ",userpath,filesep,packageName," checkout -b ",branchName));
        
        if includeRemote
            eval(strcat("!git -C ",userpath,filesep,packageName," push --set-upstream origin ",branchName));
        end
    
    else
        
        disp('Package not found, please add the package to your user path, or check the name.')
        
    end

end