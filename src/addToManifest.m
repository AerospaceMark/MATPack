% Purpose: to add to a manifest file, and create one if necessary

function addToManifest(packageName,commitID,quietFlag)
    
    if nargin < 3
        quietFlag = false;
    end

    % Getting the name of the current package
    currentPackage = getCurrentPackage; % The package from which you are
                                            % calling the manifest file
    
    pathToManifest = strcat(userpath,filesep,currentPackage,filesep,'Manifest.csv');

    if nargin < 2
        commitID = 'current';
    end
    
    if strcmp(commitID,'current') % Get the information from within the .git folder
        commitID = getCommitID(packageName);
    end
    
    packageName = string(packageName);
    commitID = string(commitID);

    if ~isfile(pathToManifest) % If the manifest file does not exist
        
        % Create the manifest file
        fid = fopen(pathToManifest,'a');
        fprintf(fid,'%s,','Package Name');
        fprintf(fid,'%s','Commit ID');
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