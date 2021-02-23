% Purpose: To create an easy way to update all of the package commit IDs to
% the top of the master branch

function updateManifest(varargin)

    p = inputParser;
    p.addParameter('CurrentCommit',false);
    
    p.parse(varargin{:});
    CurrentCommit = p.Results.CurrentCommit;

    % Getting the name of the current package
    currentPackage = getCurrentPackage; % The package from which you are
                                            % calling the manifest file
    
    pathToManifest = strcat(userpath,filesep,currentPackage,filesep,'Manifest.csv');
    
    if isfile(pathToManifest)
        manifest = readtable(pathToManifest,'delimiter',',');

        for i = 1:height(manifest)

            packageName = manifest{i,1};
            
            if ~CurrentCommit
                usePackage(packageName{1},'master',true);
            end
            addToManifest(packageName{1},'current',true);

        end
        
        disp(strcat("Updated 'Manifest.csv' in the '",currentPackage,"' package."))
        
    else
        disp(strcat("No Manifest file detected for the '",currentPackage,"' package."))
    end

end