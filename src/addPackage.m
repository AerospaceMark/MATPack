% addPackage(pathToPackage,packageName)
% 
% This is a function that adds a MATLAB package to your path.

% - Clone a package from an online Git repository
%       - pathToPackage = the cloning url
%       - packageName = the name you want to give the package. If left
%       empty, it defaults to the default cloning name.
%
% Author: Mark C. Anderson
% Institution: Brigham Young University

function addPackage(pathToPackage,packageName)
    
    % Clone the package from an online Git repository 
    if pathToPackage(end-3:end) == '.git'
        disp(strcat("Cloning ",pathToPackage," into ",userpath))
        
        if nargin < 2
            separators = strfind(pathToPackage,'/'); % Find all of the file separators
            finalSlash = separators(end); % Choose the final file separator
            packageName = pathToPackage(finalSlash + 1:end - 4); % Take the text after the final
                                                                 % file separator and before
                                                                 % the '.git'
        end
        
        if isfolder([userpath,filesep,packageName])
            alreadyExists(packageName)
            return
        end
        
        command = strcat("git clone ",convertCharsToStrings(pathToPackage),...
            " ",userpath,filesep,convertCharsToStrings(packageName));
        
        [successFlag, output] = runSystemCommand(command,false);
        
        if ~successFlag
            
            disp('Error while adding the package. System output is:')
            disp(output)
            
        end
        
    else
        
        disp('Unable to add package.')
        
    end

end

function alreadyExists(packageName)

    disp(['Package "',packageName,'" already exists in ',userpath])

end