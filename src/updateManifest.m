% Purpose: To create an easy way to update all of the package commit IDs to
% the top of the master branch

function updateManifest()
    
    % Getting the name of the current package
    currentPackage = getCurrentPackage; % The package from which you are
                                            % calling the manifest file
    
    pathToManifest = strcat(userpath,filesep,currentPackage,filesep,'Manifest.csv');

    manifest = readtable(pathToManifest,'delimiter',',');
    
    for i = 1:height(manifest)
    
        packageName = manifest{i,1};
        usePackage(packageName{1},'master');
        addToManifest(packageName{1},'current');
        
    end

end