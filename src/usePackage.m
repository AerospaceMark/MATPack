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
    
    % Getting the current commit ID
    currentID = getCommitID(packageName);
    
    % Finding out the master branch commit ID
    if getCommitID(packageName,"main") ~= 0
        mainID = getCommitID(packageName,"main");
    elseif  getCommitID(packageName,"master") ~= 0
        mainID = getCommitID(packageName,"master");
    else
        fprintf(2,strcat("\n\nNo main/master branch found for the '",...
                  packageName,"' package. Please fix this.\n\n"))
    end
        
    
    % Comparing the current commitID to the master commitID
    if currentID == mainID
        commitID = "main";
    else
        commitID = currentID;
    end

    % Seeing if the package exists in the user directory (Documents/MATLAB)
    if isfolder(strcat(userpath,filesep,packageName))
        
        command = strcat("git -C ",userpath,filesep,packageName," checkout ",commitID," -q");
        
        [successFlag,output] = runSystemCommand(command,false);
        
        if ~successFlag
            
            % If you tried the 'main' branch and it didn't work, try
            % 'master' instead
            if strcmp(commitID,"main")
                
                commitID = "master";
                command = strcat("git -C ",userpath,filesep,packageName," checkout ",commitID," -q");
                [successFlag,output] = runSystemCommand(command,false);
                
                if ~successFlag
                    
                    fprintf(2,strcat("\nError checking out '",packageName,...
                        "'.\nMATPack will add the folder at its current state\n"...
                        ,"without checking out a commit. System output is:\n\n'",output,"'\n\n"))
                    
                end
                
            else
            
                fprintf(2,strcat("\nError checking out '",packageName,...
                        "'.\nMATPack will add the folder at its current state\n"...
                        ,"without checking out a commit. System output is:\n\n'",output,"'\n\n"))
            end
            
        end
        
        addpath(genpath(strcat(userpath,filesep,packageName)));
   
    else
        disp('Package not found, please add the package to your user path, or check the name.')
        
    end

end