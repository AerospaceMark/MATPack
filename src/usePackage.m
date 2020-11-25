% This is a function that adds a MATLAB package to your path.
%
% Add a package that already exists in the userpath folder
%    - packageName = just the name of the package (eg.
%      'General-Signal-Processing')
%
% Author: Mark C. Anderson
% Institution: Brigham Young University

function usePackage(packageName,commitID,quietFlag)
    
    if nargin < 2
        commitID = "master";
    end
    
    if nargin < 3
        quietFlag = false;
    end
    
    if ~quietFlag
            disp(strcat("Adding: ",strcat(userpath,filesep,packageName," at ",commitID)))
    end
    
    % Seeing if the commitID given is equal to the commitID for the master
    % branch
    
    % Getting the current commit ID
    currentID = getCommitID(packageName);
    
    % Checking out the master branch
    eval(strcat("!git -C ",userpath,filesep,packageName," checkout ",commitID," -q"))
    masterID = getCommitID(packageName);
    
    % Comparing the current commitID to the master commitID
    if currentID == masterID
        commitID = "master";
    else
        commitID = currentID;
    end

    % Seeing if the package exists in the user directory (Documents/MATLAB)
    if isfolder(strcat(userpath,filesep,packageName))
        
        eval(strcat("!git -C ",userpath,filesep,packageName," checkout ",commitID," -q"));
        addpath(genpath(strcat(userpath,filesep,packageName)));
   
    else
        disp('Package not found, please add the package to your user path, or check the name.')
        
    end

end