% Purpose: to add to a manifest file, and create one if necessary

function addToManifest(packageName,commitID)
    
    if nargin < 2
        commitID = 'master';
    end
    
    if strcmp(commitID,'current') % Get the information from within the .git folder
        gitInfo = readtable(strcat(userpath,filesep,packageName,filesep,'.git/logs/HEAD'),'delimiter',' ');
        commitID = gitInfo{end,1};
        commitID = commitID{1};
    end
    
    packageName = string(packageName);
    commitID = string(commitID);

    if isfile('Manifest.csv') % If the manifest file is in the current folder
        
        fid = fopen('Manifest.csv','a');
        
    elseif isfile(strcat('..',filesep,'ManifestFile.csv')) % If the manifest file
                                                           % is in the folder
                                                           % above
                                                       
        fid = fopen(strcat('..',filesep,'Manifest.csv'),'a');
                                                       
    else % create the manifest file in the current folder
        
        fid = fopen('Manifest.csv','a');
        fprintf(fid,'%s,','Package Name');
        fprintf(fid,'%s','Commit ID');
        
    end
    
    fprintf(fid,'\n %s,',packageName);
    fprintf(fid,'%s',commitID);
    fclose(fid);

end