% addToManifest(packageName,commitID,targetPackage,quietFlag)
%
% Purpose: to add a given package to the current package's manifest file.
% If no manifest file is found, then one is created.

function addToManifest(packageName,commitID,targetPackage,quietFlag)
    
    if nargin < 4
        quietFlag = false;
    end
    
    if nargin < 3 % If the target package is not specified
        % Getting the name of the current package
        targetPackage = getCurrentPackage; % The package from which you are
                                            % calling the manifest file
    end
    
    if nargin < 2
        commitID = 'current';
    end
    
    if contains(targetPackage,filesep)
        pathToManifest = strcat(targetPackage,filesep,'Manifest.csv');
    else
        pathToManifest = strcat(userpath,filesep,targetPackage,filesep,'Manifest.csv');
    end
        
    if strcmp(commitID,'current') % Get the information from within the .git folder
        commitID = getCommitID(packageName);
    end
    
    packageName = string(packageName);
    commitID = string(commitID);

    if ~isfile(pathToManifest) % If the manifest file does not exist
        
        % Create the manifest file
        fid = fopen(pathToManifest,'a');
        fprintf(fid,'%s,','PackageName');
        fprintf(fid,'%s','CommitID');
        fclose(fid);
        
    end
    
    manifest = readtable(pathToManifest,'delimiter',',');
    
    packageData = [packageName,commitID];
    
    isPackage = false;
    for i = 1:height(manifest)
        
        % If the package you are trying to add already exists in the
        % manifest file, then just replace that line in the file with the
        % proper commit ID
        if strcmp(manifest{i,1},string(packageName))
            
            isPackage = true;
            manifest{i,2} = {packageData(2)};
            
        end
        
    end
    
    if ~isPackage
        manifest = [manifest;table(packageData(1),packageData(2),'VariableNames',["PackageName","CommitID"])];
    end
    
    writetable(manifest,pathToManifest)
    
    if ~quietFlag
        disp(strcat("Added ",packageName," at ",commitID,"."))
    end

end