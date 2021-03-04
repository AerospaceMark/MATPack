% Purpose: to get the top commit in a branch

function commitID = getTopCommit(packageName,branch)

    path = strcat(userpath,filesep,packageName,filesep,...
            '.git',filesep,'refs',filesep,'heads',filesep,branch);

    f = fopen(path);
    
    % Extracting the data. It came out as a nested cell array, so it was
    % extracted recursively. There is certainly a better way to do this.
    commitID = textscan(f,'%s %*[^\n]');
    commitID = commitID{1};
    commitID = commitID{1};

end