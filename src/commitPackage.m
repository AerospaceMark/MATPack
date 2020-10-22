function commitPackage(packageName,commitMessage)

    packageName = convertCharsToStrings(packageName);
    commitMessage = convertCharsToStrings(commitMessage);
    
    eval(strcat("!git -C ",userpath,filesep,packageName," add ."));
    eval(strcat("!git -C ",userpath,filesep,packageName," commit -m ",'"',commitMessage,'"'));

end