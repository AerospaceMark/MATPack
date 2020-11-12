% This is a function that adds a MATLAB package to your path. There are
% two cases:
%
% 1. Add a package that already exists in the userpath folder
%       - packageName = just the name of the package (eg.
%       'General-Signal-Processing')
%
% 2. Add a package that exists in a specified path on your computer
%       - packageName = the absolute path to the package on your computer
%
% Author: Mark C. Anderson
% Institution: Brigham Young University

function usePackage(packageName,commitID)
    
    if nargin < 2
        commitID = "master";
    end

    % 1. Seeing if the package exists in the user directory (Documents/MATLAB)
    if isfolder(strcat(userpath,filesep,packageName))
        eval(strcat("!git -C ",userpath,filesep,packageName," checkout ",commitID," -q"));
        addpath(genpath(strcat(userpath,filesep,packageName)));
        disp(strcat("Added: ",strcat(userpath,filesep,packageName," at ",commitID)))
    
    % 2. Seeing if the package exists elsewhere on the computer
    elseif isfolder(packageName)
        eval(strcat("!git -C ",packageName," checkout ",commitID))
        addpath(genpath(packageName))
        disp(strcat("Added: ",packageName," at ",commitID))
    
    % 3. Clone the package from an online Git repository
    else
        disp('Package not found, please add the package to your user path, or check the name.')
        
    end

end