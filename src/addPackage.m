% addPackage(pathToPackage,packageName)
% 
% This is a function that adds a MATLAB package to your path. There are
% three cases:
%
% 1. Add a package that already exists in the userpath folder. This will do
% nothing because the package already exists there.
%       - pathToPackage = just the name of the package (eg.
%       'General-Signal-Processing')
%       - packageName = empty
%
% 2. Add a package that exists in a specified path on your computer. This
% will then copy the entire package into the userpath folder. Updates made
% in the original folder will not be reflected in the userpath folder
% unless they are pushed from the original folder to an online Git provider
% and then pulled into the userpath folder.
%       - pathToPackage = the absolute path to the package on your computer
%       - packageName = empty
%
% 3. Clone a package from an online Git repository
%       - pathToPackage = the cloning url
%       - packageName = the name you want to give the package. If left
%       empty, it defaults to the default cloning name.
%
% Author: Mark C. Anderson
% Institution: Brigham Young University

function addPackage(pathToPackage,packageName)
    
    % 1. Seeing if the package exists in the user directory (Documents/MATLAB)
    if isfolder(strcat(userpath,filesep,pathToPackage))
        disp(strcat("Package already exists at ",userpath,filesep,pathToPackage))
    
    % 2. Seeing if the package exists elsewhere on the computer
    elseif isfolder(pathToPackage)
        eval(strcat("!cp -r ",convertCharsToStrings(pathToPackage)," ",userpath))
        disp(strcat("Copied ",convertCharsToStrings(pathToPackage)," to ",userpath,"."))
    
    % 3. Clone the package from an online Git repository 
    elseif pathToPackage(end-3:end) == '.git'
        disp(strcat("Cloning ",pathToPackage," into ",userpath))
        
        if nargin < 2
            separators = strfind(pathToPackage,'/'); % Find all of the file separators
            finalSlash = separators(end); % Choose the final file separator
            packageName = pathToPackage(finalSlash + 1:end - 4); % Take the text after the final
                                                                 % file separator and before
                                                                 % the '.git'
        end
        
        eval(strcat("!git clone ",convertCharsToStrings(pathToPackage)," ",userpath,filesep,convertCharsToStrings(packageName)))
        
    else
        disp('Unable to add package.')
        
    end

end