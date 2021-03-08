% This is a function that adds a MATLAB package to your path.
%
% 1. Forget a package that already exists in the userpath folder
%       - pathToPackage = just the name of the package (eg.
%       'General-Signal-Processing')
%       - packageName = empty

function forgetPackage(packageName)
    
    % 1. Seeing if the package exists in the user directory (Documents/MATLAB)
    if isfolder(strcat(userpath,filesep,packageName))
        rmpath(genpath(strcat(userpath,filesep,packageName)));
        disp(strcat("Forgotten: ",strcat(userpath,filesep,packageName)))
    
    else
        disp('Package not found, please check the name.')
        
    end

end