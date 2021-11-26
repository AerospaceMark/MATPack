% Purpose: To create an easy way to update all of the package commit IDs to
% the top of the master branch

function updateManifest(targetPath,commit)

    if nargin < 2
        commit = false;
    end

    if nargin < 1 % If no path is specified, use the current path
        % Getting the name of the current path
        targetPath = pwd(); % The path from which you are
                                                % calling the manifest file
    end
    
    if contains(targetPath,filesep)
        pathToManifest = strcat(targetPath,filesep,'Manifest.csv');
    else
        pathToManifest = strcat(userpath,filesep,targetPath,filesep,'Manifest.csv');
    end
    
    if isfile(pathToManifest)
        manifest = readtable(pathToManifest,'delimiter',',');

        for i = 1:height(manifest)

            packageName = manifest{i,1};
            
            % Getting the commitID for the top of the main branch
            commitID = [];
            
            try % See if you can find the main branch
                commitID = getTopCommit(packageName{1},'main');
            catch % If not, try the master branch name instead
                if isempty(commitID)
                    try 
                        commitID = getTopCommit(packageName{1},'master');
                    catch
                        disp(['Failed to update the ',packageName{1},...
                              ' package in the Manifest.csv file for the',...
                              targetPath,' package.'])
                    end
                end
            end
            
            addToManifest(packageName{1},commitID,targetPath,true);

        end
        
        disp(strcat("Updated 'Manifest.csv' in the '",targetPath,"' path."))
        
        % Make this update a commit
        if commit == true
            
            command = strcat("git -C ",userpath,filesep,targetPath," add Manifest.csv");
            
            [successFlag, output] = runSystemCommand(command,true);
        
            if ~successFlag

                disp('Error while staging the Manifest file. System output is:')
                disp(output)
                return

            end
            
            command = strcat("git -C ",userpath,filesep,targetPath," commit -m ",'"',"Automatic_Update_Manifest.csv",'"');
            
            [successFlag, output] = runSystemCommand(command,true);
        
            if ~successFlag

                disp('Error while committing the Manifest file. System output is:')
                disp(output)

            end
            
        end
        
    else
        disp(strcat("No Manifest file detected for the '",targetPath,"' path."))
    end

end