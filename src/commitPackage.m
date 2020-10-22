% Purpose: commit changes to Git for a particular package
%
% Inputs:
%   - packageName: the name of the package in single quotes
%   - commitMessage: the commit message you'd like to include in single
%   quotes

function commitPackage(packageName,commitMessage)

    packageName = convertCharsToStrings(packageName);
    commitMessage = convertCharsToStrings(commitMessage);
    
    eval(strcat("!git -C ",userpath,filesep,packageName," add ."));
    eval(strcat("!git -C ",userpath,filesep,packageName," commit -m ",'"',commitMessage,'"'));

end