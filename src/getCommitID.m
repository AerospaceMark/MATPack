function commitID = getCommitID(packageName)

    f = fopen(strcat(userpath,filesep,packageName,filesep,'.git/logs/HEAD'));
    gitInfo = textscan(f,'%s %s %*[^\n]');
    fclose(f);
    commitID = gitInfo{2};
    commitID = commitID{end};
        
end