% Purpose: To create an easy way to update all of the package commit IDs to
% the top of the master branch

function updateManifest()

    % Getting the name of the current package
    currentPackage = getCurrentPackage; % The package from which you are
                                            % calling the manifest file
    
    pathToManifest = strcat(userpath,filesep,currentPackage,filesep,'Manifest.csv');
    
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
                    commitID = getTopCommit(packageName{1},'master');
                end
            end
            
            addToManifest(packageName{1},commitID,true);

        end
        
        disp(strcat("Updated 'Manifest.csv' in the '",currentPackage,"' package."))
        
    else
        disp(strcat("No Manifest file detected for the '",currentPackage,"' package."))
    end

end