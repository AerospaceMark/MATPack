% This is a function that adds a MATLAB package to your path. There are
% two cases:
%
% 1. Forget a package that already exists in the userpath folder
%       - pathToPackage = just the name of the package (eg.
%       'General-Signal-Processing')
%       - packageName = empty
%
% 2. Forget a package that exists in a specified path on your computer
%       - pathToPackage = the absolute path to the package on your computer
%       - packageName = empty
%
% Author: Mark C. Anderson
% Institution: Brigham Young University

function forgetPackage(packageName)
    
    % 1. Seeing if the package exists in the user directory (Documents/MATLAB)
    if isfolder(strcat(userpath,filesep,packageName))
        rmpath(genpath(strcat(userpath,filesep,packageName)));
        disp(strcat('Forgotten: ',strcat(userpath,filesep,packageName)))
    
    % 2. Seeing if the package exists elsewhere on the computer
    elseif isfolder(packageName)
        rmpath(genpath(packageName))
        disp(strcat('Forgotten: ',packageName))
    
    % 3. Clone the package from an online Git repository 
    else
        disp('Package not found, please check the name.')
        
    end

end