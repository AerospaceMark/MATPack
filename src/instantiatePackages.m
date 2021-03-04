% Purpose: to take all of the packages in the 'Manifest.csv' file and check
% them out at the proper commits

function instantiatePackages()
    
%     disp('Forgetting all packages in the userpath (except for MATPack) to give you a nice, clean slate...')
%     forgetAllPackages()
%     
%     disp('Adding the packages that are specified in the Manfiest.csv file...')
%     disp(' ')
    
    % Getting the name of the current package
    currentPackage = getCurrentPackage; % The package from which you are
                                            % calling the manifest file
                                            
    getPackageList(currentPackage)
    
    
    
    % Adding the current path
    pathToCurrentPackage = strcat(userpath,filesep,currentPackage);
    disp(strcat("Adding: ",pathToCurrentPackage," at it's current state (not a commit)"));
    addpath(genpath(pathToCurrentPackage));
    
    disp(' ')
    disp('Done adding all packages from the Manifest.csv file.')
    disp(' ')
    
end

function getPackageList(package)

    % Get the dependencies from the package from which you are
    % instantiating
    dependencies = getDependencies(package);
    
    % Initializing the package list with some values
    for i = 1:height(dependencies)
        
        packageList(i+1,1) = string(dependencies(i,1));
        
    end
    
    packageList(1,2) = string(package);
    
    for i = 1:height(dependencies)
        
        packageList(i+1,2) = string(dependencies(i,2));
        
    end
    
    for i = 1:length(packageList)
        
        % Save the current width of the package list for use in indexing
        % later
        listWidth = width(packageList);
        
        % If there is a package name there, get its dependencies
        if ~ismissing(packageList(i,1))
            
            dependencies = getDependencies(packageList(i,1));
            
            % Add the dependencies to the package list
            for j = 1:height(dependencies)

                % Find the location in the package list of the current
                % dependency
                index = contains(packageList,string(dependencies(j,1)));
                
                % Turn that position into indices that we can use
                [row,~] = find(index,1);
                
                if ~isempty(row) % If the package already is in the list
                    
                    % Add a new column with the current package name (added
                    % redundantly each time, there is a better way to do this)
                    packageList(1,listWidth+1) = string(packageList(i,1));
                    
                    % Add the commit ID in the proper row and column
                    packageList(row,listWidth+1) = string(dependencies(j,2));
                
                else % Add the package to the list
                    
                end

            end
            
        end
        
        
       
    end

end

function dependencies = getDependencies(package)

    pathToManifest = strcat(userpath,filesep,package,filesep,'Manifest.csv');
    
    if isfile(pathToManifest) % If the manifest file is in the current folder
        
        dependencies = readtable(pathToManifest);
        dependencies = table2array(dependencies);
                                                       
    else
        
        dependencies = [];
        
    end

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