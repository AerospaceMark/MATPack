% Purpose: To create an easy way to update all of the package commit IDs to
% the top of the master branch

function updateManifest()
    
    manifest = readtable('Manifest.csv','delimiter',',');
    
    for i = 1:height(manifest)
    
        packageName = manifest{i,1};
        usePackage(packageName{1},'master');
        addToManifest(packageName{1},'current');
        
    end

end