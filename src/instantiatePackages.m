% Purpose: to take all of the packages in the 'Manifest.csv' file and check
% them out at the proper commits

function instantiatePackages()
    
    disp('Forgetting all packages in the userpath (except for MATPack) to give you a nice, clean slate...')
    forgetAllPackages()
    disp(' ')
    
    disp('Adding the packages that are specified in the Manfiest.csv file...')
    disp(' ')
    
    % Getting the name of the current package
    currentPackage = getCurrentPackage; % The package from which you are
                                            % calling the manifest file
    
    pathToManifest = strcat(userpath,filesep,currentPackage,filesep,'Manifest.csv');
                                            
    if isfile(pathToManifest) % If the manifest file is in the current folder
        
        packageInfo = readtable(pathToManifest);
        getPackages(packageInfo,currentPackage)
                                                       
    else % Return an error
        
        disp('Error: No manifest file found')
        
    end
    
    % Adding the current path
    pathToCurrentPackage = strcat(userpath,filesep,currentPackage);
    addpath(genpath(pathToCurrentPackage));
    disp(strcat("Added: ",pathToCurrentPackage," at it's current state (not a commit)"));
    
end

function getPackages(packageInfo,currentPackage)

    for i = 1:height(packageInfo)
        
        thisPackage = packageInfo{i,1:2};
        packageName = thisPackage{1};
        commitID = thisPackage{2};
               
        if ~strcmp(packageName,currentPackage)
            usePackage(packageName,commitID);
        end
        
    end

end