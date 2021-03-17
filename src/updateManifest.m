% Purpose: To create an easy way to update all of the package commit IDs to
% the top of the master branch

function updateManifest(package,commit)

    if nargin < 2
        commit = false;
    end

    if nargin < 1 % If no package is specified, use the current package
        % Getting the name of the current package
        package = getCurrentPackage; % The package from which you are
                                                % calling the manifest file
    end
    
    pathToManifest = strcat(userpath,filesep,package,filesep,'Manifest.csv');
    
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
                              package,' package.'])
                    end
                end
            end
            
            addToManifest(packageName{1},commitID,package,true);

        end
        
        disp(strcat("Updated 'Manifest.csv' in the '",package,"' package."))
        
        % Make this update a commit
        if commit == true
            
            command = strcat("git -C ",userpath,filesep,package," add Manifest.csv");
            
            [successFlag, output] = runSystemCommand(command,true);
        
            if ~successFlag

                disp('Error while staging the Manifest file. System output is:')
                disp(output)
                return

            end
            
            command = strcat("git -C ",userpath,filesep,package," commit -m ",'"',"Automatic_Update_Manifest.csv",'"');
            
            [successFlag, output] = runSystemCommand(command,true);
        
            if ~successFlag

                disp('Error while committing the Manifest file. System output is:')
                disp(output)

            end
            
        end
        
    else
        disp(strcat("No Manifest file detected for the '",package,"' package."))
    end

end