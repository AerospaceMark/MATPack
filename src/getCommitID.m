function commitID = getCommitID(packageName,topOfBranch)

    if nargin < 2
        filename = strcat(userpath,filesep,packageName,filesep,'.git/logs/HEAD');
        
        if isfile filename
            f = fopen(filename);
            gitInfo = textscan(f,'%s %s %*[^\n]');
            fclose(f);
            commitID = gitInfo{2};
            commitID = commitID{end};
        else
            commitID = 0;
        end
        
    else
        filename = strcat(userpath,filesep,packageName,filesep,...
            '.git',filesep,'refs',filesep,'heads',filesep,topOfBranch);
        
        if isfile(filename)
        
            f = fopen(filename);
            gitInfo = textscan(f,'%s');
            fclose(f);
            commitID = gitInfo{1};
            commitID = commitID{end};
            
        else
            commitID = 0;
        end
        
    end

    
        
end