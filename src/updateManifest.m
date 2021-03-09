% Purpose: To create an easy way to update all of the package commit IDs to
% the top of the master branch

function updateManifest(package)

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
        
    else
        disp(strcat("No Manifest file detected for the '",package,"' package."))
    end

end