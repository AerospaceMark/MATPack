% Purpose: to add to a manifest file, and create one if necessary

function addToManifest(packageName,commitID)
    
    if nargin < 2
        commitID = 'current';
    end
    
    if strcmp(commitID,'current') % Get the information from within the .git folder
        f = fopen(strcat(userpath,filesep,packageName,filesep,'.git/logs/HEAD'));
        gitInfo = textscan(f,'%s %s %*[^\n]');
        fclose(f);
        commitID = gitInfo{2};
        commitID = commitID{end};
    end
    
    packageName = string(packageName);
    commitID = string(commitID);

    if isfile('Manifest.csv') % If the manifest file is in the current folder
        
        path = 'Manifest.csv';
        
    elseif isfile(strcat('..',filesep,'ManifestFile.csv')) % If the manifest file
                                                           % is in the folder
                                                           % above
                                                       
        path = strcat('..',filesep,'Manifest.csv');
                                                       
    else % create the manifest file in the current folder
        
        path = 'Manifest.csv';
        
        fid = fopen(path,'a');
        fprintf(fid,'%s,','Package Name');
        fprintf(fid,'%s','Commit ID');
        fclose(fid);
        
    end
    
    manifest = readtable(path,'delimiter',',');
    
    packageData = [packageName,commitID];
    
    isPackage = false;
    for i = 1:height(manifest)
        
        if strcmp(manifest{i,1},string(packageName))
            isPackage = true;
            manifest{i,2} = {packageData(2)};
            
        end
        
    end
    
    if ~isPackage
        manifest = [manifest;table(packageData(1),packageData(2),'VariableNames',["PackageName","CommitID"])];
    end
    
    writetable(manifest,path)
    
    disp(strcat("Added ",packageName," at ",commitID,"."))

end