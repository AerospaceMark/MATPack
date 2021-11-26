% Purpose: to take all of the packages in the 'Manifest.csv' file and check
% them out at the proper commits
% 
% If the packages that you check out using this function also depend on
% other functions as written in their respective manifest files, then those
% are also automatically added. Note that this is only done once, so if the
% dependencies have dependencies which have dependencies, those are not
% added.
%
% Several potential errors are checked for and the user is alerted when
% these are found. If you want the program to stop when conflicts are
% discovered between manfest files, then set the 'catchIssues' variable to
% false. If no arguments are passed, then the issues will cause alerts on
% the screen but the code will proceed.

function instantiatePackages(catchIssues)
    
    if nargin < 1
        catchIssues = false;
    end

    disp('Forgetting all packages in the userpath (except for MATPack) to give you a nice, clean slate...')
    forgetAllPackages()
    
    disp('Adding the packages that are specified in the Manfiest.csv file...')
    disp(' ')
    
    % Getting the name of the current package
    currentPackage = getCurrentPackage; % The package from which you are
                                            % calling the manifest file
                                            
    packageList = getPackageList(currentPackage);
    
    finalList = getFinalList(packageList,catchIssues);
    
    if max(max(ismissing(finalList))) == 1
        fprintf(2,['Unable to reconcile manifest files, please make sure',...
                           '\nversions are compatible.\n\nAborting instantiatePackages...\n'])
        return
    end
    
    getPackages(finalList,currentPackage);
    
    % Adding the current path
    
    if contains(currentPackage,filesep)
        pathToCurrentPackage = currentPackage;
    else
        pathToCurrentPackage = strcat(userpath,filesep,currentPackage);
    end
    
    
    disp(strcat("Adding: ",pathToCurrentPackage," at it's current state (not a commit)"));
    addpath(genpath(pathToCurrentPackage));
    
    disp(' ')
    disp('Done adding all packages from the Manifest.csv file.')
    disp(' ')
    
end

function packageList = getPackageList(package)

    % Get the dependencies from the package from which you are
    % instantiating
    dependencies = getDependencies(package);
    
    % Initializing the package list with some values
    for i = 1:length(string(dependencies(:,1)))
        
        packageList(i+1,1) = string(dependencies(i,1));
        
    end
    
    packageList(1,2) = string(package);
    
    for i = 1:length(string(dependencies(:,1)))
        
        packageList(i+1,2) = string(dependencies(i,2));
        
    end
    
    for i = 1:length(packageList(:,1))
        
        % Save the current width of the package list for use in indexing
        % later
        listWidth = length(packageList(1,:));
        
        % If there is a package name there, get its dependencies
        if ~ismissing(packageList(i,1))
            
            dependencies = getDependencies(packageList(i,1));
            
            % Add the dependencies to the package list
            if ~isempty(dependencies)
                for j = 1:length(dependencies(:,1))

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
                        packageList(length(packageList(:,1)) + 1,1) = ...
                            string(dependencies(j,1));
                        packageList(length(packageList(:,1)),listWidth + 1) = ...
                            string(dependencies(j,2));
                    end

                end
            end
            
        end 
       
    end

end

function dependencies = getDependencies(package)

    if contains(package,filesep)
        pathToManifest = strcat(package,filesep,'Manifest.csv');
    else
        % pathToManifest = strcat(userpath,filesep,package,filesep,'Manifest.csv');
        pathToManifest = strcat(pwd(),filesep,'Manifest.csv');
    end
    
    if isfile(pathToManifest) % If the manifest file is in the current folder
        
        dependencies = readtable(pathToManifest);
        dependencies = table2array(dependencies);
                                                       
    else
        
        dependencies = [];
        
    end

end

function finalList = getFinalList(packageList,catchIssues)

    % Iterate over all the packages in the list
    for i = 2:length(packageList(:,1))
        
        uniqueVals = rmmissing(unique(packageList(i,2:end)));
        
        if length(uniqueVals) > 1 % If there is more than one commit ID
            
            warn = strcat('Warning, different commit IDs found in the\n',...
                       'different manifest files.\n');
                   
            fprintf(2,warn)
            
            disp(' ')
            
            fprintf(1,strcat('\t',string(packageList(i,1)),...
                       ' is specified by the different packages as:\n'));
            
            for j = 2:length(packageList(1,:))
                if ~ismissing(packageList(i,j))
                    fprintf(1,strcat("\t\t",packageList(1,j),":\t",packageList(i,j),'\n'))
                end
            end
            
            if catchIssues == false
                catchStatement = strcat("\n\t\tBecause the 'catchIssues' argument in\n\t\t",...
                                "'instantiatePackages()' is set to FALSE,\n\t\t",...
                                "we will use the value specified by ",...
                                string(packageList(1,2)),"\n\t\tif possible.\n\n");
                fprintf(catchStatement)
                
                finalList(i,1) = packageList(i,1);
                finalList(i,2) = packageList(i,2);
                
            else
                
                fprintf(2,['Unable to reconcile manifest files, please make sure',...
                           '\nversions are compatible.\n Aborting instantiatePackages...'])
                       
                break
            
            end
            
        else
        
            finalList(i,1) = packageList(i,1);
            finalList(i,2) = uniqueVals;
        end
        
        finalList(1,1) = "Dependency";
        finalList(1,2) = "CommitID";
        
    end

end

function getPackages(packageInfo,currentPackage)

    for i = 2:length(packageInfo(:,1))
        
        packageName = packageInfo(i,1);
        commitID = packageInfo(i,2);
               
        if ~strcmp(packageName,currentPackage)
            usePackage(packageName,commitID);
        end
        
    end

end