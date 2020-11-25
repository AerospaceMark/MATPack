% Purpose: Tp update all of the manifest files to the top of the master
% branch for all of your packages.
%
% WARNING: This is rather sloppy to do. It is better for you to
% intentionally update all manifest files yourself. However, this is a
% convenient function to have available and you are free to use it.


function updateAllManifests()
    
    disp(' ')
    disp('Updating all Manifest files...')
    disp(' ')
    
    currentPath = pwd; % Remembing your current path

    directoryInfo = dir(userpath);
    for i = 1:length(directoryInfo)
        
        pathToPackage = strcat(userpath,filesep,directoryInfo(i).name);
        if isfolder(strcat(pathToPackage,filesep,'.git'))
            cd(pathToPackage)
            updateManifest
        end
        
    end
    
    cd(currentPath) % Returingin you to your original path
    
    disp(' ')
    disp('Done updating all Manifest files.')
    disp(' ')

end