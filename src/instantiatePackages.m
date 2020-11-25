% Purpose: to take all of the packages in the 'Manifest.csv' file and check
% them out at the proper commits

function instantiatePackages()
    
    disp('Forgetting all packages in the userpath (except for MATPack) to give you a nice, clean slate...')
    forgetAllPackages()
    disp(' ')
    
    disp('Adding the packages that are specified in the Manfiest.csv file...')

    if isfile('Manifest.csv') % If the manifest file is in the current folder
        
        packageInfo = readtable('Manifest.csv');
        getPackages(packageInfo)
        
    elseif isfile(strcat('..',filesep,'ManifestFile.csv')) % If the manifest file
                                                           % is in the folder
                                                           % above
                                                       
        packageInfo = readtable(strcat('..',filesep,'Manifest.csv'));
        getPackages(packageInfo)
        
    elseif isfile(strcat('..',filesep,'..',filesep,'ManifestFile.csv')) % If the manifest file
                                                       % is in the folder
                                                       % above the folder
                                                       % above

    packageInfo = readtable(strcat('..',filesep,'..',filesep,'Manifest.csv'));
    getPackages(packageInfo)
                                                       
    else % Return an error
        
        disp('Error: No manifest file found in this path or in the directory above.')
        
    end
    
    % Add the current package (from which you are calling the manifest file
    currentPackage = getCurrentPackage; % The package from which you are
                                            % calling the manifest file
    pathToCurrentPackage = strcat(userpath,filesep,currentPackage);
    addPath(genPath(pathToCurrentPackage));
    
end

function getPackages(packageInfo)

    for i = 1:height(packageInfo)
        
        thisPackage = packageInfo{i,1:2};
        packageName = thisPackage{1};
        commitID = thisPackage{2};
        
        
        
        if ~strcmp(packageName,currentPackage)
            usePackage(packageName,commitID);
        end
        
    end

end