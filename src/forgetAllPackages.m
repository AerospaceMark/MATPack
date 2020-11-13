% Purpose: To forget all packages from the Documents/MATLAB folder

function forgetAllPackages()

    directoryInfo = dir(userpath);
    warning('off','MATLAB:rmpath:DirNotFound')
    for i = 1:length(directoryInfo)
        
        path = strcat(userpath,filesep,directoryInfo(i).name);
        
        if isfolder(strcat(path,filesep,'.git')) && ~strcmp(directoryInfo(i).name,'MATPack')
            forgetPackage(directoryInfo(i).name)
        end
        
    end
    warning('on','MATLAB:rmpath:DirNotFound')

end